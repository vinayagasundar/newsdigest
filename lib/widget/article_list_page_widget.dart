import 'package:flutter/material.dart';
import 'package:newsdigest/model/article.dart';

class ArticleListPageWidget extends StatelessWidget {
  final List<Article> articles;

  const ArticleListPageWidget({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return getArticleWidget(articles[index], context);
      },
    );
  }

  Widget getArticleWidget(Article article, BuildContext context) {
    return new Container(
        constraints: new BoxConstraints.expand(
          height: 200.0,
        ),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(article.urlToImage),
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: const Alignment(1, 1),
          children: <Widget>[bottomInfoCard(article, context)],
        ));
  }

  Widget bottomInfoCard(Article article, BuildContext context) {
    return new SizedBox(
      height: 180.0,
      child: Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .merge(TextStyle(fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(article.description,
                      maxLines: 3, style: Theme.of(context).textTheme.subhead),
                ),
              ],
            ),
          )),
    );
  }
}
