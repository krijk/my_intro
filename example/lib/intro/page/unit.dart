import 'package:flutter/material.dart';
import 'package:my_intro/my_intro.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';

class Unit {

  static double offsetBack = 300;
  static double offsetMain = 800;
  static double offsetText = 1000;

  static Widget image({
    required String imageFile,
    required double x,
    required double y,
    required double w,
    required double h,
    double sizeFactor = 1.0,
    double? offset,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Align(
        alignment: Alignment(x, y),
        child: FractionallySizedBox(
          widthFactor: w * sizeFactor,
          heightFactor: h * sizeFactor,
          child: SlidingContainer(
            offset: offset ?? r0(),
            child: _getImageAsset(imageFile),
          ),
        ),
      ),
    );
  }

  static Widget text({
    required BuildContext context,
    required String text,
    double fontSize = 30,
    TextAlign textAlign = TextAlign.center,
    FontWeight? fontWeight,
    Color? color,
    required double x,
    required double y,
    double offset = 100,
  }) {
    return Align(
      alignment: Alignment(x, y),
      child: SlidingContainer(
        offset: offset,
        child: Text(
          getLabel(context, text),
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Colors.white,
            fontWeight: fontWeight?? FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Image _getImageAsset(String file) {
    return Image.asset(
      _getImagePath(file),
    );
  }

  static String _getImagePath(String file) {
    return 'assets/images/$file';
  }

  static String getLabel(BuildContext context, String text) {
    String label = text;
    if (MediaQuery.of(context).size.width <= gScreenLarge) {
      label = text.replaceAll(' ', ' \n');
    }
    return label;
  }

  static double r0() {
    return r1() + r2();
  }

  static double r1() {
    return Utl.randomInt(min: 100, max: 200).toDouble();
  }

  static double r2() {
    return Utl.randomInt(min: 200, max: 900).toDouble();
  }
}
