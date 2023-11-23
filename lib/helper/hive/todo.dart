import 'package:hive/hive.dart';

part 'todo.g.dart'; // Hive generates this file

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  // Constructor
  Todo({required this.id, required this.title, required this.description});
}
