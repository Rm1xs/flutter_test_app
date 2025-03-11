import 'package:get/get.dart';
import '../../data/models/tournament_model.dart';
import '../../domain/usecases/get_tournaments.dart';

class TournamentController extends GetxController {
  final GetTournaments getTournaments;

  TournamentController(this.getTournaments);

  var tournaments = <TournamentModel>[].obs;
  var filteredTournaments = <TournamentModel>[].obs;
  var errorMessage = ''.obs;
  var isLoading = true.obs;

  bool isSortedByDate = false;
  bool isSortedByTeamsCount = false;

  @override
  void onInit() {
    fetchTournaments();
    super.onInit();
  }

  Future<void> fetchTournaments() async {
    try {
      isLoading(true);
      errorMessage.value = '';
      tournaments.value = await getTournaments();
      filteredTournaments.assignAll(tournaments);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void filterTournaments(String query) {
    if (query.isEmpty) {
      filteredTournaments.assignAll(tournaments);
    } else {
      filteredTournaments.assignAll(
        tournaments
            .where(
              (tournament) =>
                  tournament.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }

  void sortByDate() {
    isSortedByDate = !isSortedByDate;
    filteredTournaments.assignAll(filteredTournaments.toList()
      ..sort((a, b) => isSortedByDate
          ? a.startDate.compareTo(b.startDate)
          : b.startDate.compareTo(a.startDate)));
  }

  void sortByTeamsCount() {
    isSortedByTeamsCount = !isSortedByTeamsCount;
    filteredTournaments.assignAll(filteredTournaments.toList()
      ..sort((a, b) => isSortedByTeamsCount
          ? a.teams.compareTo(b.teams)
          : b.teams.compareTo(a.teams)));
  }
}
