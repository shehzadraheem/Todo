import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';


void main() {
  group('SQLiteDatabaseHelper Tests', () {
    late SQLiteDatabaseHelper dbHelper;

    setUp(() {
      dbHelper = SQLiteDatabaseHelper();
    });

    test('Database Initialization', () async {
      final db = await dbHelper.init();
      expect(db, isNotNull);
    });

    test('Insert and Query Rows', () async {
      final rowToInsert = {
        SQLiteDatabaseHelper.columnTitle: 'Test Title',
        SQLiteDatabaseHelper.columnDescription: 'Test Description',
      };
      final insertedRowId = await dbHelper.insert(rowToInsert);

      final rows = await dbHelper.queryAllRows();
      expect(rows, isNotNull);
      expect(rows, isList);
      expect(rows, hasLength(1));

      final retrievedRow = rows[0];
      expect(retrievedRow[SQLiteDatabaseHelper.columnId], equals(insertedRowId));
      expect(retrievedRow[SQLiteDatabaseHelper.columnTitle], equals('Test Title'));
      expect(retrievedRow[SQLiteDatabaseHelper.columnDescription], equals('Test Description'));
    });

    test('Update Row', () async {
      final rowToInsert = {
        SQLiteDatabaseHelper.columnTitle: 'Test Title',
        SQLiteDatabaseHelper.columnDescription: 'Test Description',
      };
      final insertedRowId = await dbHelper.insert(rowToInsert);

      final updatedRow = {
        SQLiteDatabaseHelper.columnId: insertedRowId,
        SQLiteDatabaseHelper.columnTitle: 'Updated Title',
        SQLiteDatabaseHelper.columnDescription: 'Updated Description',
      };
      final rowsUpdated = await dbHelper.update(updatedRow);
      expect(rowsUpdated, equals(1));

      final rows = await dbHelper.queryAllRows();
      expect(rows, isNotNull);
      expect(rows, isList);
      expect(rows, hasLength(1));

      final retrievedRow = rows[0];
      expect(retrievedRow[SQLiteDatabaseHelper.columnId], equals(insertedRowId));
      expect(retrievedRow[SQLiteDatabaseHelper.columnTitle], equals('Updated Title'));
      expect(retrievedRow[SQLiteDatabaseHelper.columnDescription], equals('Updated Description'));
    });

    test('Delete Row', () async {
      final rowToInsert = {
        SQLiteDatabaseHelper.columnTitle: 'Test Title',
        SQLiteDatabaseHelper.columnDescription: 'Test Description',
      };
      final insertedRowId = await dbHelper.insert(rowToInsert);

      final rowsDeleted = await dbHelper.delete(insertedRowId);
      expect(rowsDeleted, equals(1));

      final rows = await dbHelper.queryAllRows();
      expect(rows, isNotNull);
      expect(rows, isList);
      expect(rows, hasLength(0));
    });
  });
}
