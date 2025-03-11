import '../../data/models/tournament_model.dart';

abstract class TournamentRepository {
  Future<List<TournamentModel>> fetchTournaments();
}
