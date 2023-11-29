import 'package:flutter/material.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/widgets/todo_text_field.dart';


class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
          children: [
            TodoTextField(
                controller: titleController,
                hintText: addTitle
            ),
            const SizedBox(
              height: 24,
            ),
            TodoTextField(
                controller: descriptionController,
                hintText: addDescription,
                maxLines: 5,
            ),
            const SizedBox(
              height: 34,
            ),
            ElevatedButton(
                onPressed: (){},
                child: const Text(create),
            ),
          ],
        ),
      ),
    );
  }
}


