import 'package:flutter/material.dart';
import '../widgets/tournament_table.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Турніри')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TournamentTable(),
      ),
    );
  }
}
