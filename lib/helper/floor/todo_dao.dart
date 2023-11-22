import 'package:floor/floor.dart';
import 'package:todo_flutter_yt/helper/floor/todo_entity.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM $table')
  Future<List<TodoEntity>> findAllTodos();

  @insert
  Future<int> insertTodo(TodoEntity todoEntity);

  @update
  Future<int> updateTodo(TodoEntity todoEntity);

  @delete
  Future<void> deleteTodo(TodoEntity todoEntity);

  @Query('SELECT * FROM $table WHERE id = :id')
  Future<TodoEntity?> getTodoById(int id);

  @Query('DROP TABLE IF EXISTS $table')
  Future<void> deleteTable();
}
