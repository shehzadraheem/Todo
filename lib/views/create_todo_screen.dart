import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_yt/controller/todo_controller.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/widgets/todo_text_field.dart';


class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key, this.title, this.description, this.id, this.isUpdate = false});
  final String? title;
  final String? description;
  final int? id;
  final bool isUpdate;

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {

  final controller = Get.find<TodoController>();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      controller.titleController.text = widget.title ?? '';
      controller.descriptionController.text = widget.description ?? '';
    }
  }

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
                onPressed: () async {
                  if (widget.isUpdate) {
                    controller.updateTodo(widget.id ?? -1).then((value){
                      Navigator.pop(context);
                    });
                  } else {
                    controller.insertTodo().then((value){
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 18)
                ),
                child: Text(widget.isUpdate ? update : create, style: const TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}


