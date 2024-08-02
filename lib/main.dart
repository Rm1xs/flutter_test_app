import 'package:flutter/material.dart';
import 'package:flutter_test_app/features/task/presentation/task_screen.dart';
import 'package:get/get.dart';

import 'dependencies.dart';
import 'features/task/services/task_logger.dart';

void main() {
  TaskLogger.info('App started');
  Dependencies.init();
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: TaskScreen(),
    );
  }
}
