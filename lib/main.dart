import 'package:flutter/material.dart';
import 'package:newsdigest/model/article.dart';
import 'package:newsdigest/repo/articles_repo.dart';
import 'package:newsdigest/widget/article_list_page_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ArticleRepo repo = ArticleRepo.create();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Digest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: getFetchBuilder(),
    );
  }

  Widget getFetchBuilder() {
    return FutureBuilder<List<Article>>(
      future: repo.fetchTopArticles(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ArticleListPageWidget(
            articles: snapshot.data,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
