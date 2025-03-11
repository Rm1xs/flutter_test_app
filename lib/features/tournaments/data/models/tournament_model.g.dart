// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) =>
    TournamentModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      teams: (json['teams'] as num).toInt(),
    );

Map<String, dynamic> _$TournamentModelToJson(TournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'teams': instance.teams,
    };
