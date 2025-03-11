import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/tournament_model.dart';

abstract class TournamentRemoteDataSource {
  Future<List<TournamentModel>> fetchTournaments();
}

class TournamentRemoteDataSourceImpl implements TournamentRemoteDataSource {
  final Dio dio;

  TournamentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TournamentModel>> fetchTournaments() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock_data.json');

      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;

      final tournaments = jsonList
          .map((json) => TournamentModel.fromJson(json as Map<String, dynamic>))
          .toList();

      await Future.delayed(const Duration(seconds: 3));

      return tournaments;
    } catch (e) {
      throw Exception('Помилка: $e');
    }
  }
}
