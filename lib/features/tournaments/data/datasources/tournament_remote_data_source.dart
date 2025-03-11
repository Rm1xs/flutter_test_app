import 'package:dio/dio.dart';
import '../models/tournament_model.dart';

abstract class TournamentRemoteDataSource {
  Future<List<TournamentModel>> fetchTournaments();
}

class TournamentRemoteDataSourceImpl implements TournamentRemoteDataSource {
  final Dio dio;

  TournamentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TournamentModel>> fetchTournaments() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      TournamentModel(id: 1, name: "Champions League", startDate: "2024-09-01", endDate: "2025-05-30", teams: 32),
      TournamentModel(id: 2, name: "Europa League", startDate: "2024-09-05", endDate: "2025-05-27", teams: 48),
    ];
  }
}
