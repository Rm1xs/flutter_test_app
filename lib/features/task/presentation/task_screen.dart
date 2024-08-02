import 'package:flutter/material.dart';
import 'package:flutter_test_app/features/task/controllers/task_controller.dart';
import 'package:flutter_test_app/features/task/models/task_model.dart';
import 'package:flutter_test_app/features/task/models/task_status.dart';
import 'package:get/get.dart';

class TaskScreen extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Менеджер завдань'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(() {
            return ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                TaskModel task = controller.tasks[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Завдання ${task.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        task.endTime != null
                            ? Text(
                                task.endTime != null && task.startTime != null
                                    ? 'Час виконання: ${task.endTime!.difference(task.startTime!).inSeconds} с'
                                    : 'Час виконання: Невідомо',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              )
                            : LinearProgressIndicator(
                                value: task.progress,
                                backgroundColor: Colors.grey[300],
                                color: Colors.teal,
                              ),
                        const SizedBox(height: 8),
                        Text(
                          controller.translateStatus(task.status),
                          style: TextStyle(
                            fontSize: 16,
                            color: task.status == TaskStatus.done
                                ? Colors.green
                                : task.status == TaskStatus.running
                                    ? Colors.orange
                                    : task.status == TaskStatus.paused
                                        ? Colors.red
                                        : Colors.grey,
                          ),
                        ),
                        if (task.status == TaskStatus.running)
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.pause, color: Colors.red),
                              onPressed: () {
                                task.isolate?.pause();
                                task.status = TaskStatus.paused;
                                controller.tasks.refresh();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createTasks(1);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
