import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/search_screen/search_screen.dart';
import 'package:flutter_news_app/screens/splash/splash_screen.dart';
import 'package:flutter_news_app/utils/theme_controller.dart';
import 'package:get/get.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value
            ? ThemeController.darkTheme
            : ThemeController.lightTheme,
        home: const SearchScreen(),
      );
    });
  }
}
