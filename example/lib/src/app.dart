import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro/on_boarding.dart';
import '/contents/pages.dart';
import '/contents/selection.dart';
import '/globals.dart';
import '/settings/controller.dart';
import '/settings/drawer/view.dart';
import '/src/searcher.dart';

/// Necessary when resizing the app so the tree view example inside the
/// main view doesn't loose its tree states.
const GlobalObjectKey<State<StatefulWidget>> examplesViewKey = GlobalObjectKey('<ExamplesViewKey>');

class TheApplication extends StatefulWidget {
  final bool? showAppIntro;

  const TheApplication({super.key, this.showAppIntro});

  @override
  TheApplicationState createState() => TheApplicationState();
}

class TheApplicationState extends State<TheApplication> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: initializePreference(context),
      builder: (BuildContext context, AsyncSnapshot<bool> snap) {
        if (snap.hasData) {
          return buildContents(context);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildContents(BuildContext context) {
    final AppBrightness prefAppBrightness = context.select<SettingsController, AppBrightness>(
          (SettingsController controller) => controller.state.appBrightness,
    );

    bool flagShowAppIntro = false;
    if(widget.showAppIntro == null){
      // アプリ起動時は preferenceの値を使用する
      final bool prefShowAppIntro = context.select<SettingsController, bool>(
            (SettingsController controller) => controller.state.showAppIntro,
      );
      flagShowAppIntro = prefShowAppIntro;
    }

    return MaterialApp(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: context.select<SettingsController, Color>(
          (SettingsController controller) => controller.state.color,
        ),
        brightness: prefAppBrightness.getBrightness(context),
      ),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
      home: flagShowAppIntro ? const OnBoardingPage() : const AppView(),
      routes: gPageGroup.routes(),
    );
  }

  Future<bool> initializePreference(BuildContext context) async {
    await context.read<SettingsController>().retrievePreference();
    return true;
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchNotifier searchNotifier = context.watch<SearchNotifier>();

    PreferredSizeWidget? appBar;
    Widget? body;
    Widget? drawer;

    if (MediaQuery.of(context).size.width > 720) {
      // Desktop
      body = const Row(
        children: <Widget>[
          SettingsView(),
          VerticalDivider(width: 1),
          Expanded(child: ContentView(key: examplesViewKey)),
        ],
      );
    } else {
      // Mobile
      appBar = AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: searchNotifier.value ? Theme.of(context).colorScheme.primaryContainer : null,
            ),
            onPressed: () {
              searchNotifier.onPressed();
            },
          ),
        ],
        title: const Text(appBarTitle),
        notificationPredicate: (_) => false,
        titleSpacing: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      );
      body = const ContentView(key: examplesViewKey);
      drawer = const Padding(
        padding: EdgeInsets.only(top: 20),
        child: SettingsView(isDrawer: true),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: drawer,
    );
  }
}
