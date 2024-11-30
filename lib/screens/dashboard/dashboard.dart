import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/dashboard/home/home_screen.dart';
import 'package:flutter_news_app/screens/dashboard/profile/profile_screen.dart';
import 'package:flutter_news_app/utils/theme_controller.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  List<Widget> pages = [const HomeScreen(), const ProfileScreen()];
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: themeController.isDarkMode.value
                ? Colors.grey.shade900
                : Colors.white,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color: currentIndex == 0 ? Colors.orange : Colors.grey),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: currentIndex == 1 ? Colors.orange : Colors.grey),
                  label: "Profile"),
            ]);
      }),
    );
  }
}
