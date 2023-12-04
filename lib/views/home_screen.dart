import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/views/create_todo_screen.dart';
import 'package:todo_flutter_yt/controller/todo_controller.dart';

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

class HomeBody extends GetView<TodoController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: controller.getAllTodo(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong.'));
        } else if (snapshot.hasData && snapshot.data != null) {
           return Obx((){
             return ListView.builder(
               itemCount: controller.listOfMaps.length,
               itemBuilder: (_, index) {
                 final todo = controller.listOfMaps[index];

                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                   child: Card(
                     elevation: 1.0,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Text(todo[columnTitle], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                           Text(todo[columnDescription], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                         ],
                       ),
                     ),
                   ),
                 );
               },
             );
           });
        }
        return const Center(child: Text('Something went wrong.'));
      },
    );
  }
}