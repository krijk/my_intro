import 'package:flutter/material.dart';
import '../helper.dart';
import '../model/page_view_model.dart';
import 'intro_content.dart';

class IntroPage extends StatefulWidget {
  final PageViewModel page;
  final ScrollController? scrollController;

  const IntroPage({
    super.key,
    required this.page,
    this.scrollController,
  });

  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildStack() {
    final PageViewModel page = widget.page;
    final IntroContent content = IntroContent(page: page, isFullScreen: true);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        if (page.image != null) page.image!,
        Positioned.fill(
          child: Column(
            children: <Widget>[
              ...<Widget>[
                Spacer(flex: page.decoration.imageFlex),
                Expanded(
                  flex: page.decoration.bodyFlex,
                  child: page.useScrollView
                      ? SingleChildScrollView(
                          controller: widget.scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: content,
                        )
                      : content,
                ),
              ].asReversed(page.reverse),
              if (page.footer != null)
                Flexible(
                  flex: page.decoration.footerFlex,
                  fit: page.decoration.footerFit,
                  child: page.footer!,
                ),
              SafeArea(
                top: false,
                child: SizedBox(
                  height: page.decoration.safeArea,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlex(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final PageViewModel page = widget.page;

    return Container(
      color: page.decoration.pageColor,
      decoration: page.decoration.boxDecoration,
      margin: page.decoration.pageMargin,
      child: Flex(
        direction:
            page.useRowInLandscape && orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ...<Expanded>[
            if (page.image != null)
              Expanded(
                flex: page.decoration.imageFlex,
                child: Align(
                  alignment: page.decoration.imageAlignment,
                  child: Padding(
                    padding: page.decoration.imagePadding,
                    child: page.image,
                  ),
                ),
              ),
            Expanded(
              flex: page.decoration.bodyFlex,
              child: Align(
                alignment: page.decoration.bodyAlignment,
                child: page.useScrollView
                    ? SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: IntroContent(page: page),
                      )
                    : IntroContent(page: page),
              ),
            ),
          ].asReversed(page.reverse),
          if (page.footer != null)
            Flexible(
              flex: page.decoration.footerFlex,
              fit: page.decoration.footerFit,
              child: page.footer!,
            ),
          SizedBox(height: page.decoration.safeArea),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.page.decoration.fullScreen) {
      return _buildStack();
    }
    return _buildFlex(context);
  }
}
