import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.initSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Icon(Icons.newspaper_rounded,
              color: Colors.blueGrey.shade900, size: 100.0)),
    );
  }
}
