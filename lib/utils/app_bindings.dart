import 'package:get/get.dart';
import 'package:todo_flutter_yt/controller/todo_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController(), fenix: true);
  }
}