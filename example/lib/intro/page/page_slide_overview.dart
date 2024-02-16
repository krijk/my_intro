import 'package:flutter/material.dart';
import 'package:my_intro/my_intro.dart';

import 'unit.dart';

class PageSlideOverview extends StatelessWidget {
  const PageSlideOverview(
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
          Unit.image(imageFile: 'main_admob_flutter.png', x: 0, y: 0, w: 0.8, h: 0.4, offset: Unit.offsetMain),
          Unit.image(imageFile: 'i_ad_marketing.png', x: 0.1, y: -0.4, w: 0.25, h: 0.20, opacity: 0.2),
          Unit.image(imageFile: 'i_ad_social.png', x: -0.9, y: -0.6, w: 0.3, h: 0.3, opacity: 0.5),
          Unit.image(imageFile: 'i_browse.png', x: 0.3, y: 0.3, w: 0.14, h: 0.07, opacity: 0.5),
          Unit.image(imageFile: 'i_comment.png', x: 0.8, y: -0.3, w: 0.15, h: 0.10, opacity: 0.2),
          Unit.image(imageFile: 'i_date.png', x: -0.7, y: 0.3, w: 0.15, h: 0.15, opacity: 0.4),
          Unit.text(context: context, text: 'AdMob + Flutter', x: 0, y: 0.6, offset: Unit.offsetText),
        ],
      ),
    );
  }
}
