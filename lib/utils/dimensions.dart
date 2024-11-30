import 'package:flutter/material.dart';
import 'package:flutter_news_app/main.dart';

class Dimensions {
  static Widget getHeight(double height) {
    return SizedBox(height: height);
  }

  static Widget getWidth(double width) {
    return SizedBox(width: width);
  }

  static double deviceWidth() {
    return MediaQuery.of(navigationKey.currentContext!).size.width;
  }

  static double deviceHeight() {
    return MediaQuery.of(navigationKey.currentContext!).size.height;
  }
}
