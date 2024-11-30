import 'package:flutter/material.dart';
import 'package:flutter_news_app/utils/strings.dart';
import 'package:flutter_news_app/utils/theme_controller.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> preferenceList = ["Theme"];
  List<Widget> icons = [
    const Icon(Icons.dark_mode),
    const Icon(Icons.bookmark)
  ];
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return TextWidget(
              title: AppString.profile,
              color: themeController.isDarkMode.value
                  ? Colors.orange
                  : Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold);
        }),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  themeController.toggleTheme();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return TextWidget(
                          title: preferenceList[index],
                          color: themeController.isDarkMode.value
                              ? Colors.grey
                              : Colors.orange,
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold);
                    }),
                    icons[index]
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
                color: Colors.grey, height: 10.0, thickness: 1.0);
          },
          itemCount: preferenceList.length),
    );
  }
}
