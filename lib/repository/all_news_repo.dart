import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter_news_app/api/api.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/utils/strings.dart';
import 'package:flutter_news_app/widgets/alert_dialog.dart';
import 'package:get/get.dart';

class AllNewsRepo {
  Api api = Api();

  Future<NewsModel> fetchAllNews() async {
    try {
      var response = await api.sendRequest.get(
          "everything?q=apple&from=2024-11-28&to=2024-11-28&sortBy=popularity&apiKey=${AppString.apiKey}");
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
