import 'package:flutter/material.dart';
import 'package:flutter_news_app/main.dart';
import 'package:flutter_news_app/screens/dashboard/dashboard.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void initSplashScreen() {
    debugPrint("Init Controller");
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(navigationKey.currentContext!,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
    });
  }
}
