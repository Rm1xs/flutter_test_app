import 'dart:isolate';

class TaskModel {
  final int id;
  String status;
  double progress;
  DateTime? startTime;
  DateTime? endTime;
  Isolate? isolate;
  ReceivePort? receivePort;

  TaskModel({required this.id, this.status = 'pending', this.progress = 0.0});
}
