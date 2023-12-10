import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/utils/custom_snackbar.dart';

class TodoCubit extends Cubit<List<Map<String, dynamic>>> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late SQLiteDatabaseHelper _databaseHelper;

  TodoCubit() : super([]) {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _databaseHelper = SQLiteDatabaseHelper()..init();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  Future<void> insertTodo() async {
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
      emit([...state, updatedTodo]);
      CustomSnackbar.show('Alert', 'Todo added successfully');
      clearControllers();
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
    }
  }

  Future<void> getAllTodo() async {
    try {
      final database = await _databaseHelper.database;
      final rows = await _databaseHelper.queryAllRows(database);
      emit(rows);
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong: $e');
    }
  }

  Future<void> updateTodo(int id) async {
    try {
      final todo = {
        columnId: id,
        columnTitle: titleController.text,
        columnDescription: descriptionController.text,
      };
      final database = await _databaseHelper.database;
      await _databaseHelper.update(todo, database);

      int index = state.indexWhere((element) => element[columnId] == id);
      final newState = List<Map<String, dynamic>>.from(state);
      newState[index] = todo;

      emit(newState);
      CustomSnackbar.show('Alert', 'Todo updated successfully');
      clearControllers();
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final database = await _databaseHelper.database;
      await _databaseHelper.delete(id, database);

      int index = state.indexWhere((element) => element[columnId] == id);
      final newState = List<Map<String, dynamic>>.from(state);
      newState.removeAt(index);

      emit(newState);
      CustomSnackbar.show('Alert', 'Todo deleted successfully');
    } catch (e) {
      CustomSnackbar.show('Warning', 'Something went wrong');
    }
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
  }
}
