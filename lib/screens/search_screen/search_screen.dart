import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/search_screen/controller/search_controller.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';
import 'package:flutter_news_app/widgets/textfield_widget.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchTextController searchController = Get.put(SearchTextController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const TextWidget(
              title: "Search App List",
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: TextFieldWidget(
                  hintText: "Search something",
                  onChanged: (value) => searchController.searchAnimal(value),
                  controller: searchController.searchController))),
      body: Obx(() => ListView.separated(
            itemCount: searchController.filteredList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                leading: TextWidget(
                    title: searchController.filteredList[index],
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1.0,
                color: Colors.grey,
              );
            },
          )),
    );
  }
}
