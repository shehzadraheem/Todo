import 'package:todo_flutter_yt/helper/floor/floor_todo_database.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';


class DatabaseHelper {
  Future<FloorToDoDatabase> getDatabase() async {
    final database = await $FloorFloorToDoDatabase.databaseBuilder(databaseName).build();
    return database;
  }

  // Future<void> closeDatabase() async {
  //   final db = await getDatabase();
  //   db.close();
  // }
}
