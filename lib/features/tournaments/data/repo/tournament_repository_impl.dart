import '../../domain/repo/tournament_repository.dart';
import '../datasources/tournament_remote_data_source.dart';
import '../models/tournament_model.dart';

class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentRemoteDataSource remoteDataSource;

  TournamentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TournamentModel>> fetchTournaments() async {
    return await remoteDataSource.fetchTournaments();
  }
}
