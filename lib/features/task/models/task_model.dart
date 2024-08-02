import 'dart:isolate';
import 'task_status.dart';

class TaskModel {
  final int id;
  TaskStatus status;
  double progress;
  DateTime? startTime;
  DateTime? endTime;
  Isolate? isolate;
  ReceivePort? receivePort;

  TaskModel({
    required this.id,
    this.status = TaskStatus.pending,
    this.progress = 0.0,
    this.startTime,
    this.endTime,
    this.isolate,
    this.receivePort,
  });
}
