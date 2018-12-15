import 'dart:convert';
import 'package:newsdigest/model/article.dart';
import 'package:newsdigest/constant.dart';
import 'package:http/http.dart' as http;

class TopArticleRequest {
  final int page;
  final String country;

  TopArticleRequest({this.page = 0, this.country});
}

abstract class ArticleRepo {
  factory ArticleRepo.create() {
    return _ArticleRepoImpl();
  }

  Future<List<Article>> fetchTopArticles(TopArticleRequest request);
}

class _ArticleRepoImpl implements ArticleRepo {
  @override
  Future<List<Article>> fetchTopArticles(TopArticleRequest request) async {
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?apiKey=' +
            API_KEY +
            '&country=${request.country}' +
            '&page=${request.page}');

    if (response.statusCode == 200) {
      return _parseArticleList(json.decode(response.body));
    } else {
      throw Exception('Faile to Load articles');
    }
  }

  List<Article> _parseArticleList(Map<String, dynamic> json) {
    List<Article> artilcles = new List();
    List<dynamic> articlesArray = json['articles'];

    for (dynamic articleRes in articlesArray) {
      if (articleRes is Map<String, dynamic>) {
        artilcles.add(Article.fromJson(articleRes));
      }
    }

    return List.unmodifiable(artilcles);
  }
}
