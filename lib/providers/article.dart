import 'package:flutter/material.dart';

class Article with ChangeNotifier {
  String link;
  String title;
  String image;

  Article(
    this.link,
    this.title,
    this.image,
  );
}
