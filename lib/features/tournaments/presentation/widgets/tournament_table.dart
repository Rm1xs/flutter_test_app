import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tournament_controller.dart';

class TournamentTable extends StatelessWidget {
  const TournamentTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TournamentController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return DataTable(columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Start Date')),
        DataColumn(label: Text('End Date')),
        DataColumn(label: Text('Teams')),
      ], rows: controller.tournaments.map((tournament) {
        return DataRow(cells: [
          DataCell(Text(tournament.name)),
          DataCell(Text(tournament.startDate)),
          DataCell(Text(tournament.endDate)),
          DataCell(Text(tournament.teams.toString())),
        ]);
      }).toList());
    });
  }
}
