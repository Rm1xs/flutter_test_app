import 'package:flutter/material.dart';
import 'package:flutter_test_app/features/task/models/task_status.dart';
import 'package:flutter_test_app/features/task/services/task_service.dart';
import 'package:get/get.dart';

import '../models/task_model.dart';
import '../services/task_logger.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  final TaskService taskService = TaskService();

  @override
  void onInit() {
    super.onInit();
    createTasks(5);
  }

  void createTasks(int count) {
    for (int i = 0; i < count; i++) {
      TaskModel task = TaskModel(id: tasks.length + 1);
      tasks.add(task);
      startTask(task);
    }
    _checkAllTasksComplete();
  }

  void startTask(TaskModel task) async {
    TaskLogger.info('Starting task ${task.id}');
    taskService.startTask(task, () {
      TaskLogger.info('Task ${task.id} completed');
      tasks.refresh();
      _checkAllTasksComplete();
    });
  }

  void _checkAllTasksComplete() {
    if (tasks.every((task) => task.status == TaskStatus.done)) {
      Get.snackbar(
        'Усі завдання виконано',
        'Усі завдання були завершені.',
        backgroundColor: Colors.teal,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
      TaskLogger.info('All tasks completed');
    }
  }

  String translateStatus(TaskStatus status) {
    switch (status) {
      case TaskStatus.done:
        return 'Завдання виконано';
      case TaskStatus.running:
        return 'Завдання виконується';
      case TaskStatus.paused:
        return 'Завдання призупинено';
      case TaskStatus.pending:
      default:
        return 'Завдання очікує';
    }
  }
}
