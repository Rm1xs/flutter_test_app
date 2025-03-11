import '../../data/models/tournament_model.dart';
import '../repo/tournament_repository.dart';

class GetTournaments {
  final TournamentRepository repository;

  GetTournaments(this.repository);

  Future<List<TournamentModel>> call() async {
    return await repository.fetchTournaments();
  }
}
