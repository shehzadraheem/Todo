import 'package:todo_flutter_yt/helper/object_box/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_flutter_yt/helper/object_box/objectbox.g.dart';

class ToDoService {
  late final Store _store;
  late final Box<ToDo> _box;

  ToDoService() {
   //_initializeStore();
  }

  Future<void> initializeStore() async {
    final dir = await getApplicationDocumentsDirectory();
    _store = Store(getObjectBoxModel(), directory: '${dir.path}/objectbox');
    _box = _store.box<ToDo>();
  }


  // Create
  int createToDo(String title, String description) {
    final toDo = ToDo(title: title, description: description);
    return _box.put(toDo);
  }

  // Read
  List<ToDo> getAllToDos() {
    return _box.getAll();
  }

  ToDo? getToDo(int id) {
    return _box.get(id);
  }

  // Update
  void updateToDo(int id, String updatedTitle, String updatedDescription) {
    final toDo = _box.get(id);
    if (toDo != null) {
      toDo.title = updatedTitle;
      toDo.description = updatedDescription;
      _box.put(toDo);
    }
  }

  // Delete
  void deleteToDo(int id) {
    _box.remove(id);
  }
}
