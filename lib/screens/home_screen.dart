//import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:news_app/data/category_list.dart';
import 'package:news_app/commons/common_colors.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/category_news_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().getTrendingNews();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: .center,
          children: [
            Text("World", style: TextStyle(fontWeight: .bold)),
            Text(
              "News",
              style: TextStyle(
                color: CommonColors.primaryColor,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: .horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryNewsScreen(category: categories[index]),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.redAccent,
                              CommonColors.primaryColor,
                            ],
                          ),
                          color: CommonColors.primaryColor,
                          borderRadius: .circular(20),
                        ),
                        width: 150,
                        height: 100,
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: .centerLeft,
              child: Text(
                "Trending news!",
                style: TextStyle(fontSize: 18, fontWeight: .bold),
              ),
            ),
            Expanded(
              child: Consumer<NewsProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.trendingNews.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () async {
                            // logger.log(
                            //   provider.trendingNews[index]["url"],
                            try {
                              await launchUrl(
                                Uri.parse(provider.trendingNews[index]["url"]),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Image.network(
                                  provider.trendingNews[index]["urlToImage"] ?? "https://www.bing.com/th/id/OIP.6YU6nn_ENinIIyPw8PaLigAAAA?w=193&h=273&c=8&rs=1&qlt=90&o=6&pid=ImgAns&rm=2",
                                  height: 110,
                                  width: 110,
                                  fit: .cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 110,
                                      ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 5,
                                    children: [
                                      Text(
                                        maxLines: 2,
                                        overflow: .ellipsis,
                                        provider.trendingNews[index]["title"] ??
                                            "Unknown title",
                                        style: TextStyle(fontWeight: .bold),
                                      ),
                                      Text(
                                        maxLines: 2,
                                        overflow: .ellipsis,
                                        provider.trendingNews[index]["description"] ??
                                            "Unkonwn description",
                                        style: TextStyle(
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
