import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:todo_flutter_yt/helper/floor/todo_dao.dart';
import 'package:todo_flutter_yt/helper/floor/todo_entity.dart';

part 'floor_todo_database.g.dart';

@Database(version: 1, entities: [TodoEntity])
abstract class FloorToDoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
