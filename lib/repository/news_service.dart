import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article.dart';

class NewsRepository {
  final String url =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=e5c8c029b6084ff9bc0c9fe22b09a0ae';

  Future<List<Article>> getNews() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> articlesData = jsonData["articles"];

      // Convert the list of articles' JSON data into a list of Article objects
      List<Article> articles = articlesData.map((articleJson) {
        return Article.fromJson(articleJson);
      }).toList();

      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
