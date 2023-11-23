import 'package:hive/hive.dart';
import 'package:todo_flutter_yt/helper/hive/todo.dart';

class HiveDatabase {
  late Box<Todo> todoBox;

  Future<void> init() async {
    Hive.registerAdapter(TodoAdapter());
    todoBox = await Hive.openBox<Todo>('todoBox');
  }

  int get nextId {
    return todoBox.values.isEmpty ? 0 : (todoBox.values.last.id + 1);
  }

  Future<void> addTodo(String title, String description) async {
    final todo = Todo(id: nextId, title: title, description: description);
    await todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(int id, String title, String description) async {
    final todo = todoBox.get(id);
    if (todo != null) {
      todo.title = title;
      todo.description = description;
      await todo.save();
    }
  }

  Future<void> deleteTodo(int id) async {
    await todoBox.delete(id);
  }

  List<Todo> getTodos() {
    return todoBox.values.toList();
  }

  Future<void> close() async {
    await todoBox.close();
  }
}
