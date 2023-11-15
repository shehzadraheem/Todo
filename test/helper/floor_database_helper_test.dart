import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter_yt/helper/floor/floor_todo_database.dart';
import 'package:todo_flutter_yt/helper/floor/todo_dao.dart';
import 'package:todo_flutter_yt/helper/floor/todo_entity.dart';


Future main() async {
  late FloorToDoDatabase database;
  late TodoDao todoDao;

  setUpAll(() async {
    database = await $FloorFloorToDoDatabase
        .inMemoryDatabaseBuilder()
        .build();

    todoDao = database.todoDao;
  });

  group('Database Test', () {

    test('Insert Row', () async {
      final todo = TodoEntity(title: 'Title 1', description: 'des');
      await todoDao.insertTodo(todo);
      final actual = await todoDao.findAllTodos();

      expect(actual, hasLength(1));
    });

    // test('Update Row', () async {
    //   final todo = TodoEntity(title: 'Title 1', description: 'des');
    //   int count = await dbHelper.update(updatedTodo, database);
    //   expect(count, 1); // Check if one row is updated
    // });
    //
    test('Delete Row', () async {
      final todo = TodoEntity(title: 'Title 1', description: 'des');
      await todoDao.deleteTodo(todo);
      final actual = await todoDao.findAllTodos();

      expect(actual, isEmpty);
    });
    //
    // test('Row Count', () async {
    //   int count = await dbHelper.queryRowCount(database);
    //   expect(count, 0); // Or the expected number of rows after the above operations
    // });
    //
    // test('Close db', () async {
    //   await database.close();
    //   expect(database.isOpen, false);
    // });

  });
}
