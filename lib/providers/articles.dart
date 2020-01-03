import 'package:flutter/material.dart';

import '../api.dart';
import './article.dart';

class Articles with ChangeNotifier {
  Articles() {
    if (_articles.length == 0) {
      this.fetchAndSet(0, 5);
    }
  }
  var response;

  List<Article> _articles = [];

  List<Article> get articles {
    return [..._articles];
  }

  Future<void> fetchAndSet(int offset, int perPage) async {
    response = await Api().fetchArticles(offset, perPage);
    final data = response.data;
    List<Article> _temp = [];
    for (var i = 0; i < data.length; i++) {
      _temp.add(Article(
        data[i]['link'],
        data[i]['title']['rendered'],
        data[i]['jetpack_featured_media_url'],
      ));
    }
    _articles = _temp;

    notifyListeners();
  }
}
