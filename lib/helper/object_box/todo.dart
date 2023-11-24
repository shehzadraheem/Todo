import 'package:objectbox/objectbox.dart';

@Entity()
class ToDo {
  int id = 0; // ObjectBox manages this field as an auto-increment ID
  String title;
  String description;

  ToDo({this.id = 0, required this.title, required this.description});
}
