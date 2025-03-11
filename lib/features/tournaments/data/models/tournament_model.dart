import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/tournament.dart';

part 'tournament_model.g.dart';

@JsonSerializable()
class TournamentModel {
  final int id;
  final String name;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  final int teams;

  TournamentModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.teams,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentModelToJson(this);
}

extension TournamentModelX on TournamentModel {
  Tournament toEntity() {
    return Tournament(
      id: id,
      name: name,
      startDate: startDate,
      endDate: endDate,
      teams: teams,
    );
  }
}
