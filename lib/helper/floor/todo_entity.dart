import 'package:floor/floor.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';

@Entity(tableName: table)
class TodoEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String description;

  TodoEntity({this.id, required this.title, required this.description});
}
