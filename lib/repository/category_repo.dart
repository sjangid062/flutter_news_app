import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/api/api.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/utils/strings.dart';
import 'package:flutter_news_app/widgets/alert_dialog.dart';
import 'package:get/get.dart';

class CategoryRepo {
  Api api = Api();

  Future<NewsModel> fetchNewsByCategory(String category) async {
    try {
      var response = await api.sendRequest.get(
          "top-headlines?country=us&category=$category&apiKey=${AppString.apiKey}");
      NewsModel newsModel = newsModelFromJson(jsonEncode(response.data));
      debugPrint("NewsModel : $newsModel");
      return newsModel;
    } catch (e) {
      AlertDialogWidget(
          buttonTitle: "Ok",
          errorMessage: "Something Went Wrong",
          errorTitle: "Error",
          onPressed: () => Get.back());
      rethrow;
    }
  }
}
