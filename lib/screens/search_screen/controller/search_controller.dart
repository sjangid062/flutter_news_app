import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTextController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  RxList<String> animalName = [
    "Giraffe",
    "Lion",
    "Tiger",
    "Elephant",
    "Fox",
    "Lizard",
    "Snake",
    "Cheetah",
    "Bear"
  ].obs;

  RxList<String> filteredList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    filteredList = animalName;
  }

  void searchAnimal(String query) {
    if (query.isEmpty) {
      filteredList.value = animalName;
    } else {
      filteredList.value = animalName
          .where((element) =>
              element.toLowerCase().contains(query.toString()) &&
              element.toUpperCase().contains(query.toString()))
          .toList();
    }
  }

  @override
  void onClose() {
    super.onClose();
    searchController.clear();
    filteredList.value = animalName;
  }
}
