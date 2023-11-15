import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// main () {
//   // 1. setUpAll - Runs once before all tests or groups.
//   setUpAll(() async {
//     // Code here runs before any tests are executed.
//   });
//
//   // 2. group - Organizes tests into groups.
//   group('Group Name', () {
//     // 3. setUp - Runs before each test in the group.
//     setUp(() {
//       // Code here runs before each test in this group.
//     });
//
//     // 4. test - Individual tests.
//     test('Test Description', () {
//       // Test code goes here.
//     });
//
//     // You can have multiple tests within a group.
//     test('Another Test', () {
//       // Another test's code.
//     });
//
//     // 5. tearDown - Runs after each test in the group.
//     tearDown(() {
//       // Code here runs after each test in this group.
//     });
//   });
//
//   // You can have multiple groups in the same test file.
//   group('Another Group', () {
//     // Additional tests and setups.
//   });
//
//   // 6. tearDownAll - Runs once after all tests or groups.
//   tearDownAll(() {
//     // Code here runs after all tests are completed.
//   });
// }

Future main() async {
  late Database database;
  late SQLiteDatabaseHelper dbHelper;

  // Setup sqflite_common_ffi for flutter test
  setUpAll(() async {
    dbHelper = SQLiteDatabaseHelper();

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
    // test('sqflite version', () async {
    //   expect(await database.getVersion(), 1);
    // });
    //
    // test('add todo to database', () async {
    //   var i = await database.insert(table, newTodo);
    //   var p = await database.query(table);
    //   expect(p.length, i);
    //   expect(p, [{columnId: 1, columnTitle: 'Testing', columnDescription: 'Sample Description'}]);
    // });
    //
    // test('update first Item', () async {
    //   await database.update(table, updatedTodo, where: '$columnId = ?', whereArgs: [1]);
    //   var p = await database.query(table);
    //   expect(p.first[columnTitle], 'Testing Updated');
    // });
    //
    // test('delete the first Item', () async {
    //   await database.delete(table, where: '$columnId = ?', whereArgs: [1]);
    //   var p = await database.query(table);
    //   expect(p.length, 0);
    // });


    test('Insert Row', () async {
      final newTodo = {
        columnTitle: 'Test Todo',
        columnDescription: 'Test Description'
      };
      int id = await dbHelper.insert(newTodo, database);
      expect(id, isNotNull); // Check if id is not null, indicating insertion was successful
    });

    test('Query Row', () async {
      final rows = await dbHelper.queryAllRows(database);
      expect(rows.isNotEmpty, true); // Check if rows are returned
    });

    test('Update Row', () async {
      final updatedTodo = {
        columnId: 1,
        columnTitle: 'Updated Todo',
        columnDescription: 'Updated Description'
      };
      int count = await dbHelper.update(updatedTodo, database);
      expect(count, 1); // Check if one row is updated
    });

    test('Delete Row', () async {
      int count = await dbHelper.delete(1, database);
      expect(count, 1); // Check if one row is deleted
    });

    test('Row Count', () async {
      int count = await dbHelper.queryRowCount(database);
      expect(count, 0); // Or the expected number of rows after the above operations
    });

    test('Close db', () async {
      await database.close();
      expect(database.isOpen, false);
    });

  });
}
