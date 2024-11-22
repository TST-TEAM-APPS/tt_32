import 'package:flutter/material.dart';
import 'UI/onboaring.dart';
import 'Widgets/bottom_navigation_bar.dart';
import 'Widgets/is_first.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: IsFirstRun.isFirstRun(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return OnboardingScreen();
          } else {
            return ChangeBodies();
          }
        },
      ),
    );
  }
}
