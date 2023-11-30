import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_yt/controller/todo_controller.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/widgets/todo_text_field.dart';


class CreateTodoScreen extends GetView<TodoController> {
  const CreateTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                controller: controller.titleController,
                hintText: addTitle
            ),
            const SizedBox(
              height: 24,
            ),
            TodoTextField(
                controller: controller.descriptionController,
                hintText: addDescription,
                maxLines: 5,
            ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(
                onPressed: (){
                  controller.insertTodo();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 18)
                ),
                child: const Text(create, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}


