import 'package:flutter/material.dart';

import '/intro/on_boarding.dart';

class AppIntroduction extends StatelessWidget {
  final bool shouldPop;

  const AppIntroduction({super.key, this.shouldPop = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Introduction'),
      subtitle: const Text('App intro'),
      leading: const Icon(Icons.announcement),
      onTap: () {
        navigate(context);
      },
    );
  }

  void navigate(BuildContext context) {
    if (shouldPop) {
      Navigator.pop(context);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<StatefulWidget>(builder: (_) => const OnBoardingPage()),
      // MaterialPageRoute(builder: (_) => const AppView()),
    );
  }
}
