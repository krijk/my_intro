import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '/intro/on_boarding.dart';
import '/src/navigation.dart';

class AppIntro extends AbstractSettingsTile {
  const AppIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: const Text('Introduction'),
      leading: const Icon(Icons.update),
      description: const Text('Show app introduction'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const OnBoardingPage(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}
