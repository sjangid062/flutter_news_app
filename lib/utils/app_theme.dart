import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/utils/fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      fontFamily: Fonts.ptsans,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent)));

  static final darkTheme = ThemeData(
      fontFamily: Fonts.ptsans,
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade400,
          surfaceTintColor: Colors.grey,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent)));
}
