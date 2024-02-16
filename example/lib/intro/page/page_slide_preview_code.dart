import 'package:flutter/material.dart';
import 'package:my_intro/my_intro.dart';

import 'unit.dart';

class PageSlidePreviewCode extends StatelessWidget {
  const PageSlidePreviewCode(
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
          Unit.image(imageFile: 'i_world01.png', x: 0, y: 0, w: 1, h: 0.4, offset: Unit.offsetBack),
          Unit.image(imageFile: 'main_preview_code.png', x: 0, y: 0, w: 0.9, h: 0.5, offset: Unit.offsetMain),
          Unit.image(imageFile: 'i_mobile.png', x: 0.2, y: -0.5, w: 0.2, h: 0.20, opacity: 0.2),
          Unit.image(imageFile: 'i_opinion.png', x: -0.5, y: -0.8, w: 0.2, h: 0.3, opacity: 0.5),
          Unit.image(imageFile: 'i_picture.png', x: 0.3, y: 0.35, w: 0.14, h: 0.07, opacity: 0.8),
          Unit.image(imageFile: 'i_pie_chart.png', x: 0.85, y: -0.3, w: 0.15, h: 0.10, opacity: 0.8),
          Unit.image(imageFile: 'i_set_up.png', x: -0.7, y: 0.3, w: 0.15, h: 0.15, opacity: 0.6),
          Unit.text(context: context, text: 'Preview Code Share', x: 0, y: 0.6, offset: Unit.offsetText),
        ],
      ),
    );
  }

}
