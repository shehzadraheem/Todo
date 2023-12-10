import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_yt/cubit/todo_cubit.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/widgets/todo_text_field.dart';


class CreateTodoScreen extends StatelessWidget {
  const CreateTodoScreen({super.key, this.title, this.description, this.id, this.isUpdate = false});
  final String? title;
  final String? description;
  final int? id;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    if (isUpdate) {
      todoCubit.titleController.text = title ?? '';
      todoCubit.descriptionController.text = description ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(createTodo),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TodoTextField(
                controller: todoCubit.titleController,
                hintText: addTitle
            ),
            const SizedBox(
              height: 24,
            ),
            TodoTextField(
                controller: todoCubit.descriptionController,
                hintText: addDescription,
                maxLines: 5,
            ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (isUpdate) {
                    todoCubit.updateTodo(id ?? -1).then((value){
                      Navigator.pop(context);
                    });
                  } else {
                    todoCubit.insertTodo().then((value){
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 18)
                ),
                child: Text(isUpdate ? update : create, style: const TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}


