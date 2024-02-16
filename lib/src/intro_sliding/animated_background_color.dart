import 'package:flutter/widgets.dart';

/// [AnimatedBackgroundColor] background widget. Animates color
/// change when scrolling to new [SlidingPage] in [PageView].
///
/// [pageController] controller of [PageView]. Used for animated color transition.
///
/// [pageCount] total count of [SlidingPage] in [PageView].
///
/// [colors] array of colors for transition. [colors] length can be different from
/// [pageCount], then color change will cycle through available colors.
///
/// [child] widget displayed over [AnimatedBackgroundColor].
class AnimatedBackgroundColor extends StatelessWidget {
  const AnimatedBackgroundColor({
    required this.child,
    required this.pageController,
    required this.pageCount,
    this.colors = const <Color>[
      Color(0xFFAAAAAA),
      Color(0xFF669900),
      Color(0xFFCC0000),
      Color(0xFF0099CC),
      Color(0xFFAA66CC),
      Color(0xFFFF8800),
    ],
    super.key,
  });

  final PageController pageController;
  final int pageCount;
  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final TweenSequence<Color?> background = TweenSequence<Color?>(
      List<TweenSequenceItem<Color?>>.generate(pageCount, (int i) {
        return TweenSequenceItem<Color?>(
          weight: 1,
          tween: ColorTween(
            begin: colors[i % colors.length],
            end: colors[(i + 1) % colors.length],
          ),
        );
      }),
    );

    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? child) {
        final double color = pageController.hasClients ? pageController.page! / pageCount : .0;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: background.evaluate(AlwaysStoppedAnimation<double>(color)),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
