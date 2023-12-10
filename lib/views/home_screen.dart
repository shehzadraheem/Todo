import 'package:flutter/material.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/utils/constant/constant.dart';
import 'package:todo_flutter_yt/views/create_todo_screen.dart';
import 'package:todo_flutter_yt/widgets/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_yt/cubit/todo_cubit.dart';

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
    return BlocBuilder<TodoCubit, List<Map<String, dynamic>>>(
      builder: (context, todoList) {
        if (todoList.isEmpty) {
          // Load todos when the list is empty
          context.read<TodoCubit>().getAllTodo();
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList[index];

            return Dismissible(
              key: Key(todo[columnId].toString()),
              background: Container(
                color: Colors.green,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  // Delete action
                  final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Are you sure you want to delete this todo?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              context.read<TodoCubit>().deleteTodo(todo[columnId]);
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return res;
                } else {
                  // Edit action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CreateTodoScreen(
                        title: todo[columnTitle],
                        description: todo[columnDescription],
                        id: todo[columnId],
                        isUpdate: true,
                      ),
                    ),
                  );
                }
              },
              child: TodoItem(
                title: todo[columnTitle],
                description: todo[columnDescription],
              ),
            );
          },
        );
      },
    );
  }
}