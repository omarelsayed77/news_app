import 'package:api_lec2/models/news%20model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NewsProvider with ChangeNotifier {
  NewsProvider() {
    getAllData();
  }
  String selectedCategory = "general";
  Dio dio = Dio();
  List<Article> articles = [];

  changeCategory(String category) {
    selectedCategory = category;
    getAllData();
    notifyListeners();
  }

  getAllData() async {
    articles = [];
    String url =
        "https://newsapi.org/v2/top-headlines?country=eg&category=$selectedCategory&apiKey=21ec5da562414c9e9fb0525d87dbb2e6";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        print(response.data['articles']);
        response.data['articles'].forEach((value) {
          articles.add(Article.fromJson(value));
        });
        notifyListeners();
        print(articles);
      }
    } catch (e) {
      print("errrrrrrrrrrrrrrrrrrrrrrror");
    }
    notifyListeners();
  }
}
