import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/repository/all_news_repo.dart';
import 'package:flutter_news_app/repository/category_repo.dart';
import 'package:flutter_news_app/screens/article_screen/article_screen.dart';
import 'package:flutter_news_app/utils/images.dart';
import 'package:flutter_news_app/utils/network_controller.dart';
import 'package:flutter_news_app/utils/strings.dart';
import 'package:flutter_news_app/utils/theme_controller.dart';
import 'package:flutter_news_app/utils/utils.dart';
import 'package:flutter_news_app/widgets/text_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AllNewsRepo allNewsRepo = AllNewsRepo();
  CategoryRepo categoryRepo = CategoryRepo();
  TabController? tabController;
  final NetworkController networkController = Get.put(NetworkController());
  final ThemeController themeController = Get.find();
  List<String> tabTitle = [
    "Top News",
    "Business",
    "Technology",
    "Entertainment",
    "Sports"
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitle.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return TextWidget(
              title: AppString.appName,
              color: themeController.isDarkMode.value
                  ? Colors.orange
                  : Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold);
        }),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: tabController,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicator: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.orange, width: 2.0))),
                onTap: (value) {
                  categoryRepo.fetchNewsByCategory(tabTitle[value]);
                },
                tabs: List.generate(
                    tabTitle.length,
                    (index) => Obx(() {
                          return TextWidget(
                              title: tabTitle[index],
                              color: themeController.isDarkMode.value
                                  ? Colors.grey
                                  : Colors.orangeAccent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold);
                        })))),
      ),
      body: Obx(() {
        if (networkController.networkState.value == NetworkState.disconnected) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 100, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      networkController.checkConnectivity();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }
        return TabBarView(
          controller: tabController,
          children: List.generate(
            tabTitle.length,
            (index) {
              if (tabTitle[index] == tabTitle[0]) {
                return FutureBuilder<NewsModel>(
                    future: allNewsRepo.fetchAllNews(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.articles
                            .where((element) =>
                                element.title != "[Removed]" &&
                                element.author != null &&
                                element.source.id != null &&
                                element.content != "" &&
                                element.description != "" &&
                                element.url != "")
                            .toList();
                        return RefreshIndicator(
                          onRefresh: () {
                            return allNewsRepo.fetchAllNews();
                          },
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var article = data[index];

                                return InkWell(
                                  highlightColor: Colors.grey.shade100,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ArticleScreen(
                                                article: article)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                      title: article.title,
                                                      color:
                                                          Colors.orangeAccent,
                                                      fontSize: 16.0,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10.0),
                                                SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                      title: article.content,
                                                      color: Colors.grey,
                                                      fontSize: 14.0,
                                                      maxLines: 3,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            article.urlToImage != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                        article.urlToImage!,
                                                        height: 100.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                        AppImages.blankImage,
                                                        height: 100.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                                title: Utils.formatDate(
                                                    article.publishedAt),
                                                color: Colors.grey,
                                                fontSize: 13.0,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.share))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                    color: Colors.grey,
                                    height: 20.0,
                                    thickness: 1.0);
                              },
                              itemCount: data!.length),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              } else {
                return FutureBuilder<NewsModel>(
                    future: categoryRepo.fetchNewsByCategory(tabTitle[index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data?.articles
                            .where((element) =>
                                element.title != "[Removed]" &&
                                element.author != null &&
                                element.content != "" &&
                                element.description != "" &&
                                element.url != "")
                            .toList();
                        return RefreshIndicator(
                          onRefresh: () {
                            return categoryRepo
                                .fetchNewsByCategory(tabTitle[index]);
                          },
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                var article = data[index];
                                return InkWell(
                                  highlightColor: Colors.grey.shade100,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ArticleScreen(
                                                article: article)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                      title: article.title,
                                                      color:
                                                          Colors.orangeAccent,
                                                      fontSize: 16.0,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10.0),
                                                SizedBox(
                                                  width: 250,
                                                  child: TextWidget(
                                                      title: article.content,
                                                      color: Colors.grey,
                                                      fontSize: 14.0,
                                                      maxLines: 3,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            article.urlToImage != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                        article.urlToImage!,
                                                        height: 100.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover))
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                        AppImages.blankImage,
                                                        height: 100.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                                title: Utils.formatDate(
                                                    article.publishedAt),
                                                color: Colors.grey,
                                                fontSize: 13.0,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.share))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                    color: Colors.grey.shade300,
                                    height: 20.0,
                                    thickness: 2.0);
                              },
                              itemCount: data!.length),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              }
            },
          ),
        );
      }),
    );
  }
}
