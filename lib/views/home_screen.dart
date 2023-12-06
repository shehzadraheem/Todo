import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/views/create_todo_screen.dart';
import 'package:todo_flutter_yt/controller/todo_controller.dart';
import 'package:todo_flutter_yt/widgets/todo_item.dart';

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
               itemCount: controller.todoList.length,
               itemBuilder: (_, index) {
                 final todo = controller.todoList[index];

                 return Dismissible(
                   key: Key(todo[columnId].toString()),
                   background: Container(
                     color: Colors.green,
                     child: const Align(
                       alignment: Alignment.centerLeft,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           SizedBox(
                             width: 20,
                           ),
                           Icon(
                             Icons.edit,
                             color: Colors.white,
                           ),
                           Text(
                             ' Edit',
                             style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w700,
                             ),
                             textAlign: TextAlign.left,
                           ),
                         ],
                       ),
                     ),
                   ),
                   secondaryBackground: Container(
                     color: Colors.red,
                     child: const Align(
                       alignment: Alignment.centerRight,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: <Widget>[
                           Icon(
                             Icons.delete,
                             color: Colors.white,
                           ),
                           Text(
                             ' Delete',
                             style: TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.w700,
                             ),
                             textAlign: TextAlign.right,
                           ),
                           SizedBox(
                             width: 20,
                           ),
                         ],
                       ),
                     ),
                   ),
                   confirmDismiss: (direction) async {
                     /// Delete
                     if (direction == DismissDirection.endToStart) {
                       final bool res = await showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             return AlertDialog(
                               content: const Text(
                                   'Are you sure you want to delete this todo?'),
                               actions: <Widget>[
                                 ElevatedButton(
                                   child: const Text(
                                     'Cancel',
                                     style: TextStyle(color: Colors.black),
                                   ),
                                   onPressed: () {
                                     Navigator.of(context).pop(false);
                                   },
                                 ),
                                 ElevatedButton(
                                   child: const Text(
                                     'Delete',
                                     style: TextStyle(color: Colors.red),
                                   ),
                                   onPressed: () {
                                     controller.deleteTodo(todo[columnId]).then((value){
                                       Navigator.of(context).pop(false);
                                     });
                                   },
                                 ),
                               ],
                             );
                           });
                       return res;
                     } else {
                       /// Edit
                       Navigator.push(context, MaterialPageRoute (
                         builder: (BuildContext context) =>
                             CreateTodoScreen(
                               title: todo[columnTitle],
                               description: todo[columnDescription],
                               id: todo[columnId],
                               isUpdate: true,
                             ),
                       ));
                     }
                   },
                   child: TodoItem(
                       title: todo[columnTitle],
                       description: todo[columnDescription],
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