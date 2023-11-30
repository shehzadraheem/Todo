import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_flutter_yt/utils/app_bindings.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';
import 'package:todo_flutter_yt/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // HiveDatabase().init();
  //
  // ToDoService toDoService = ToDoService();
  // toDoService.initializeStore();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: toDoText,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      initialBinding: AppBindings(),
    );
  }
}
