import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:party_planner/UI/additional_info_screen.dart';
import 'package:party_planner/UI/onboaring.dart';
import 'package:party_planner/Widgets/bottom_navigation_bar.dart';
import 'package:party_planner/services/mixins/network_mixin.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> with NetworkMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
    super.initState();
  }

  Future<void> _navigate() async {
    await checkConnection(
      onError: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const InitialScreen(),
        ),
      ),
    );
    final isFirst = await IsFirstRun.isFirstRun();
    if (isFirst) {
      InAppReview.instance.requestReview();
    }

    if (!canNavigate) {
      if (isFirst) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ChangeBodies(),
          ),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdditionalInfoScreen(),
        ),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
