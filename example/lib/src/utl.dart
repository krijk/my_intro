import 'package:flutter/material.dart';

class UtlIntro {
  static Widget image({
    required String filename,
    double width = 350,
  }) {
    return Image.asset('assets/images/$filename', width: width);
  }
}
