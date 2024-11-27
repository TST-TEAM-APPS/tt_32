import 'package:flutter/material.dart';
import 'package:party_planner/UI/initial_screen.dart';
import 'package:party_planner/UI/onboaring.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyPlanner Pulse',
      debugShowCheckedModeBanner: false,
      home: const InitialScreen(),
    );
  }
}