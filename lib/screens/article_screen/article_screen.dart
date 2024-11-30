import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/utils/images.dart';
import 'package:flutter_news_app/utils/theme_controller.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, required this.article});

  final Article article;
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
        child: Column(children: [
          TextWidget(
              title: widget.article.title,
              color: Colors.orange,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
          const SizedBox(height: 15.0),
          widget.article.urlToImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(widget.article.urlToImage!,
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(AppImages.blankImage,
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain)),
          const SizedBox(height: 15.0),
          Obx(() {
            return TextWidget(
                title: widget.article.content,
                color: themeController.isDarkMode.value
                    ? Colors.grey
                    : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal);
          }),
          const SizedBox(height: 15.0),
          Obx(() {
            return TextWidget(
                title: widget.article.description,
                color: themeController.isDarkMode.value
                    ? Colors.grey
                    : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal);
          }),
          const SizedBox(height: 15.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.article.url,
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      try {
                        final Uri uri =
                            Uri.parse(Uri.encodeFull(widget.article.url));
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          print('Cannot launch URL: $uri');
                        }
                      } catch (e) {
                        throw e;
                      }
                    },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
