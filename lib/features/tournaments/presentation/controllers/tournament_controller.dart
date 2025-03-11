import 'package:get/get.dart';
import '../../data/models/tournament_model.dart';
import '../../domain/usecases/get_tournaments.dart';

class TournamentController extends GetxController {
  final GetTournaments getTournaments;

  TournamentController(this.getTournaments);

  var tournaments = <TournamentModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTournaments();
    super.onInit();
  }

  Future<void> fetchTournaments() async {
    try {
      isLoading(true);
      tournaments.value = await getTournaments();
    } finally {
      isLoading(false);
    }
  }
}
