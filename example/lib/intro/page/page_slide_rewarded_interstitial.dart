import 'package:flutter/material.dart';
import 'package:my_intro/my_intro.dart';

import 'unit.dart';

class PageSlideRewardedInterstitial extends StatelessWidget {
  const PageSlideRewardedInterstitial(
    this.page,
    this.notifier, {
    super.key,
  });

  final int page;
  final ValueNotifier<double> notifier;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Unit.image(imageFile: 'i_world05.png', x: 0, y: 0, w: 1, h: 0.4, opacity: 0.6, offset: Unit.offsetBack),
          Unit.image(imageFile: 'ad_rewarded_interstitial_1024.png', x: 0, y: 0, w: 0.8, h: 0.8, offset: Unit.offsetMain),
          Unit.image(imageFile: 'm_coin01.png', x: 0.5, y: 0.3, w: 0.25, h: 0.20, opacity: 0.5),
          Unit.image(imageFile: 'm_euro01.png', x: -0.5, y: 0.5, w: 0.2, h: 0.2, opacity: 0.5),
          Unit.image(imageFile: 'm_bag_dollar01.png', x: 0.3, y: -0.35, w: 0.2, h: 0.2, opacity: 0.6),
          Unit.image(imageFile: 'm_bill_dollar01.png', x: -0.6, y: -0.1, w: 0.2, h: 0.20, opacity: 0.5),
          Unit.image(imageFile: 'i_information.png', x: -0.4, y: -0.4, w: 0.15, h: 0.15, opacity: 0.2),
          Unit.text(context: context, text: 'Rewarded InterstitialAds', x: 0, y: 0.6, offset: Unit.offsetText),
        ],
      ),
    );
  }
}
