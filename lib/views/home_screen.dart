import 'package:flutter/material.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/views/create_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeText),
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final dbHelper = SQLiteDatabaseHelper();
          //
          // final rows = await dbHelper.queryAllRows();
          // for (var element in rows) {
          //   log('result: ${element.values}');
          // }

          // FloorToDoDatabase dbHelper = await DatabaseHelper().getDatabase();
          // final todoDao = dbHelper.todoDao;
          //
          // final newTodo = TodoEntity(
          //   title: 'testing 3',
          //   description: 'Sample Description',
          // );
          //
          //
          // await todoDao.insertTodo(newTodo);
          //
          // final list = await todoDao.findAllTodos();
          // for(TodoEntity entity in list){
          //   log('Todo Title: ${entity.title}');
          // }
          Navigator.push(context, MaterialPageRoute (
             builder: (BuildContext context) => const CreateTodoScreen(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [

      ],
    );
  }
}