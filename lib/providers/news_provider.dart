import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as logger;

class NewsProvider extends ChangeNotifier {
  List trendingNews = [];
  bool isLoading = false;

  //get isTrendingNewsLoading => null;
  Future getTrendingNews() async {
    isLoading = true;
    notifyListeners();
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=7881887b3077464f9c67c2ba200997c0";
      http.get(Uri.parse(url));
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        final decodedData = jsonDecode(data);
        trendingNews = decodedData["articles"];
        notifyListeners();
        logger.log(trendingNews.toString());
      } else {
        logger.log("Api calling failed");
      }
    } catch (e) {
      logger.log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  List categoryNews = [];
  bool isCategoryNewsLoading = false;

  //get isTrendingNewsLoading => null;


  Future getCategoryNews(String category) async {
    isCategoryNewsLoading = true;
    notifyListeners();
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=us&category&apiKey=7881887b3077464f9c67c2ba200997c0";
      http.get(Uri.parse(url));
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        final decodedData = jsonDecode(data);
        categoryNews = decodedData["articles"];
        notifyListeners();
        logger.log(categoryNews.toString());
      } else {
        logger.log("Api calling failed");
      }
    } catch (e) {
      logger.log(e.toString());
    } finally {
      isCategoryNewsLoading = false;
      notifyListeners();
    }
  }
}
