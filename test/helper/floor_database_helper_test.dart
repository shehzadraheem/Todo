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

    test('Update Row', () async {
      final todo = TodoEntity(title: 'TDD', description: 'Test Driven Development');
      final insertTodoId = await todoDao.insertTodo(todo);
      final updatedTodo = TodoEntity(id: insertTodoId, title: 'Update TDD', description: 'Test Driven Development');

      await todoDao.updateTodo(updatedTodo);

      final actual = await todoDao.getTodoById(insertTodoId);
      expect(actual?.title, equals(updatedTodo.title));
    });

    test('Delete Row', () async {
      final todo = TodoEntity(title: 'Title 1', description: 'des');
      await todoDao.deleteTodo(todo);
      final actual = await todoDao.findAllTodos();

      expect(actual, isNotEmpty);
    });
  });
}
