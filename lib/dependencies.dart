import 'package:get/get.dart';
import 'features/task/controllers/task_controller.dart';

class Dependencies {
  static void init() {
    Get.put(TaskController(), permanent: true);
  }
}
