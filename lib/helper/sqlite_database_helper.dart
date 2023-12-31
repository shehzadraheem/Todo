import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';

class SQLiteDatabaseHelper{
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await init();
    return _db!;
  }

  Future<Database?> init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    _db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
    return _db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row, Database db) async {
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(Database db) async {
    return await db.query(table);
  }

  Future<int> queryRowCount(Database db) async {
    final results = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row, Database db) async {
    int id = row[columnId];
    return await db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id, Database db) async {
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearTable(Database db) async {
    await db.rawDelete('DELETE FROM $table');
  }

  Future<void> deleteTable(Database db) async {
    await db.execute('DROP TABLE IF EXISTS $table');
  }
}