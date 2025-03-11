import 'package:equatable/equatable.dart';

class Tournament extends Equatable {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final int teams;

  const Tournament({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.teams,
  });

  @override
  List<Object> get props => [id, name, startDate, endDate, teams];
}
