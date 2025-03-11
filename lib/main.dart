import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dependencies.dart';
import 'features/tournaments/presentation/pages/tournament_screen.dart';

void main() {
  Dependencies.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: TournamentScreen());
  }
}
