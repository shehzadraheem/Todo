import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/utils/custom_snackbar.dart';

class TodoController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late SQLiteDatabaseHelper _databaseHelper;
  //RxMap<String, dynamic> todoList = <String, dynamic>{}.obs;
  RxList<Map<String, dynamic>> todoList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _databaseHelper = SQLiteDatabaseHelper()..init();
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<bool> insertTodo() async {
    try {
      final todo = {
        columnTitle: titleController.text,
        columnDescription: descriptionController.text,
      };
      final database = await _databaseHelper.database;
      final result = await _databaseHelper.insert(todo, database);

      final updatedTodo = {
        ...todo,
        columnId: result,
      };
      todoList.add(updatedTodo);
      CustomSnackbar.show('Alert', 'Todo added successfully');
      clearControllers();
      return true;
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllTodo() async {
    try {
      final database = await _databaseHelper.database;

      final rows = await _databaseHelper.queryAllRows(database);
      todoList.clear();
      todoList.addAll(rows);
      return rows;
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong : $e');
      return null;
    }
  }

  Future<bool> updateTodo(int id) async {
    try {
      final todo = {
        columnId: id,
        columnTitle: titleController.text,
        columnDescription: descriptionController.text,
      };
      final database = await _databaseHelper.database;
      final result = await _databaseHelper.update(todo, database);

      int index = todoList.indexWhere((element) => element[columnId] == id);
      log('${todoList.length}');
      todoList[index] = todo;

      CustomSnackbar.show('Alert', 'Todo updated successfully');
      clearControllers();

      return true;
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      final database = await _databaseHelper.database;
      final result = await _databaseHelper.delete(id, database);

      int index = todoList.indexWhere((element) => element[columnId] == id);
      todoList.removeAt(index);

      CustomSnackbar.show('Alert', 'Todo deleted successfully');
      return true;
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
      return false;
    }
  }

}