import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/features/tournaments/data/models/tournament_model.dart'
    show TournamentModel;
import 'package:flutter_test_app/features/tournaments/domain/repo/tournament_repository.dart';
import 'package:flutter_test_app/features/tournaments/domain/usecases/get_tournaments.dart';
import 'package:flutter_test_app/features/tournaments/presentation/controllers/tournament_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tournament_repository_test.mocks.dart';

@GenerateMocks([TournamentRepository])
void main() {
  late TournamentController controller;
  late MockTournamentRepository mockRepository;
  late GetTournaments getTournaments;

  setUp(() {
    mockRepository = MockTournamentRepository();
    getTournaments = GetTournaments(mockRepository);
    controller = TournamentController(getTournaments);
  });

  test('Load and compare lists', () async {
    final tournaments = [
      TournamentModel(
          id: 1,
          name: "Champions League",
          startDate: "2024-09-01",
          endDate: "2025-05-30",
          teams: 32),
      TournamentModel(
          id: 2,
          name: "Europa League",
          startDate: "2024-09-05",
          endDate: "2025-05-27",
          teams: 48),
    ];

    when(mockRepository.fetchTournaments())
        .thenAnswer((_) async => tournaments);

    await controller.fetchTournaments();

    expect(controller.tournaments, contains(tournaments));
    expect(controller.isLoading.value, false);
  });
}
