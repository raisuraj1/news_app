import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String category;
  const new({super.key, required this.category});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().getCategoryNews(widget.category.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.category}News")),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return provider.isCategoryNewsLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.categoryNews.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () async {
                          // logger.log(
                          //   provider.trendingNews[index]["url"],
                          try {
                            await launchUrl(
                              Uri.parse(provider.categoryNews[index]["url"]),
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
                                provider.categoryNews[index]["urlToImage"] ?? "https://www.bing.com/th/id/OIP.6YU6nn_ENinIIyPw8PaLigAAAA?w=193&h=273&c=8&rs=1&qlt=90&o=6&pid=ImgAns&rm=2",
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
                                      provider.categoryNews[index]["title"] ??
                                          "Unknown title",
                                      style: TextStyle(fontWeight: .bold),
                                    ),
                                    Text(
                                      maxLines: 2,
                                      overflow: .ellipsis,
                                      provider.categoryNews[index]["description"] ??
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
    );
  }
}
