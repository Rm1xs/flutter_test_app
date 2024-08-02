import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import '../models/task_model.dart';

class TaskService {
  Future<void> startTask(TaskModel task, Function updateTask) async {
    task.status = 'running';
    task.startTime = DateTime.now();
    task.receivePort = ReceivePort();
    task.receivePort!.listen((message) {
      task.progress = message['progress'];
      updateTask();
      if (message['done']) {
        task.status = 'done';
        task.endTime = DateTime.now();
        task.isolate?.kill(priority: Isolate.immediate);
        task.receivePort?.close();
        updateTask();
      }
    });

    task.isolate = await Isolate.spawn(_taskRunner, task.receivePort!.sendPort);
  }

  static void _taskRunner(SendPort sendPort) async {
    Random random = Random();
    int duration = random.nextInt(5000) + 1000;
    int elapsed = 0;
    while (elapsed < duration) {
      await Future.delayed(const Duration(milliseconds: 100));
      elapsed += 100;
      sendPort.send({'progress': elapsed / duration, 'done': false});
    }
    sendPort.send({'progress': 1.0, 'done': true});
  }
}
