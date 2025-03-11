import 'features/tournaments/data/datasources/tournament_remote_data_source.dart';
import 'features/tournaments/data/repo/tournament_repository_impl.dart';
import 'features/tournaments/domain/usecases/get_tournaments.dart';
import 'features/tournaments/presentation/controllers/tournament_controller.dart';
import 'package:get/get.dart';

import 'core/network/dio_client.dart';

class Dependencies {
  static void init() {
    final dataSource = TournamentRemoteDataSourceImpl(DioClient.dio);
    final repository = TournamentRepositoryImpl(dataSource);
    final getTournaments = GetTournaments(repository);
    Get.put(TournamentController(getTournaments));
  }
}
