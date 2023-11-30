import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/utils/custom_snackbar.dart';

class TodoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late SQLiteDatabaseHelper _databaseHelper;
  RxMap<String, dynamic> todoList = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _databaseHelper = SQLiteDatabaseHelper()..init();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> insertTodo() async {
   try {
     final todo = {
       columnTitle: titleController.text,
       columnDescription: descriptionController.text,
     };
     final database = await _databaseHelper.database;
     final result = await _databaseHelper.insert(todo, database);
     CustomSnackbar.show('Alert', 'Todo added successfully');
   } catch (e) {
     CustomSnackbar.show('Warning', 'Something went wrong');
   }
  }

}