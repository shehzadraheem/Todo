import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_flutter_yt/helper/sqlite_database_helper.dart';
import 'package:todo_flutter_yt/utils/constant/app_text_constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeText),
      ),
      body: const Column(
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dbHelper = SQLiteDatabaseHelper();

          final rows = await dbHelper.queryAllRows();
          for (var element in rows) {
            log('result: ${element.values}');
          }
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
