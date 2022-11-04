import 'dart:convert';

import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_category.dart';
import 'package:http/http.dart' as http;

class NewsAPI {
  const NewsAPI();

  static const baseUrl = 'https://newsapi.org/v2';
  static const apiKey = '12ad575f13f84fd791e82c632f498e59';

  Future<List<Article>> getArticles(ArticleCategory articleCategory) async {
    String url = baseUrl;

    url += '/top-headlines';
    url += '?apiKey=$apiKey';
    url += '&language=en';
    url += '&category=${articleCategory.name}';

    final response = await http.get(
      Uri.parse(
        url,
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['status'] == 'ok') {
        final dynamic articlesJson = json['articles'] ?? [];
        final List<Article> articles = articlesJson.map<Article>((e) => Article.fromJson(e)).toList();

        return articles;
      } else {
        return [];
      }
    }

    return [];
  }
}
