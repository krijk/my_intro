import 'package:flutter/material.dart';
import 'package:my_intro/my_intro.dart';
import 'package:provider/provider.dart';

import '../src/utl.dart';
import '/settings/controller.dart';
import '/src/app.dart';
import 'page/page_slide_app_open.dart';
import 'page/page_slide_banner.dart';
import 'page/page_slide_interstitial.dart';
import 'page/page_slide_native.dart';
import 'page/page_slide_overview.dart';
import 'page/page_slide_preview_code.dart';
import 'page/page_slide_rewarded.dart';
import 'page/page_slide_rewarded_interstitial.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final GlobalKey<IntroductionScreenState> introKey = GlobalKey<IntroductionScreenState>();
  final ValueNotifier<double> notifier = ValueNotifier<double>(0);

  Future<void> _onIntroEnd(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<StatefulWidget>(
        builder: (_) => const TheApplication(
          showAppIntro: false,
        ),
      ),
    );
  }
  
  List<Widget> rawPages(){
    int idx = 0;
    final List<Widget> pages = <Widget>[];
    pages.add(PageSlideOverview(idx, notifier));
    pages.add(PageSlidePreviewCode(++idx, notifier));
    pages.add(PageSlideBanner(++idx, notifier));
    pages.add(PageSlideInterstitial(++idx, notifier));
    pages.add(PageSlideRewarded(++idx, notifier));
    pages.add(PageSlideRewardedInterstitial(++idx, notifier));
    pages.add(PageSlideAppOpen(++idx, notifier));
    pages.add(PageSlideNative(++idx, notifier));
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    // const TextStyle bodyStyle = TextStyle(fontSize: 19.0);

    /*
    const PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      // pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
     */

    return IntroductionScreen(
      key: introKey,
      // globalBackgroundColor: Colors.white,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,

      allowImplicitScrolling: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: UtlIntro.image(filename: 'logo_ad_demo_150.png', width: 80),
          ),
        ),
      ),

      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: bottomButton(context),
      ),
      rawPages: rawPages(),
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Colors.grey.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      notifier: notifier,
    );
  }

  Widget bottomButton(BuildContext context) {
    final bool current = context.select<SettingsController, bool>(
      (SettingsController controller) => controller.state.showAppIntro,
    );

    String message;
    if (current) {
      message = 'Do not show this at app starts';
    } else {
      message = 'Show this page at app starts';
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.withOpacity(0.5),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _onBottomButton(context, !current),
    );
  }

  void _onBottomButton(BuildContext context, bool value) {
    context.read<SettingsController>().updateShowIntro(value: value);
    _onIntroEnd(context);
  }
}
