import 'package:floor/floor.dart';
import 'package:todo_flutter_yt/helper/floor/todo_entity.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM $table')
  Future<List<TodoEntity>> findAllTodos();

  @insert
  Future<void> insertTodo(TodoEntity todoEntity);

  @update
  Future<void> updateTodo(TodoEntity todoEntity);

  @delete
  Future<void> deleteTodo(TodoEntity todoEntity);
}
