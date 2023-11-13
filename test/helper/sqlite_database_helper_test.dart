import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  final newTodo = {
    columnTitle: 'Testing',
    columnDescription: 'Sample Description',
  };
  final updatedTodo = {
    columnTitle: 'Testing Updated',
    columnDescription: 'Sample Description',
  };
  late Database database;

  // Setup sqflite_common_ffi for flutter test
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

    database = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL
          )
          ''');
        });
  });

  group('Database Test', () {
    test('sqflite version', () async {
      expect(await database.getVersion(), 1);
    });

    test('add todo to database', () async {
      var i = await database.insert(table, newTodo);
      var p = await database.query(table);
      expect(p.length, i);
      expect(p, [{columnId: 1, columnTitle: 'Testing', columnDescription: 'Sample Description'}]);
    });

    test('update first Item', () async {
      await database.update(table, updatedTodo, where: '$columnId = ?', whereArgs: [1]);
      var p = await database.query(table);
      expect(p.first[columnTitle], 'Testing Updated');
    });

    test('delete the first Item', () async {
      await database.delete(table, where: '$columnId = ?', whereArgs: [1]);
      var p = await database.query(table);
      expect(p.length, 0);
    });

    test('Close db', () async {
      await database.close();
      expect(database.isOpen, false);
    });

  });
}
