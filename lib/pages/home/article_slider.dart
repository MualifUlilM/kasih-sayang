import 'package:flutter/material.dart';
import 'package:KasihSayang/service/get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../providers/article.dart';

class ArticlesSlider extends StatelessWidget {
  final List<Article> _articles;
  ArticlesSlider(this._articles);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width,
      child: Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
          child: _articles.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CarouselSlider(
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  items: List.generate(
                    _articles.length,
                    (i) {
                      return Container(
                          height: 300,
                          width: 600,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(1, 2),
                                  color: Colors.grey[300],
                                  blurRadius: 10)
                            ],
                          ),
                          child: FlatButton(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height *0.15,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${_articles[i].image}'),
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.height * 0.1,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text('${_articles[i].title}'),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () async {
                              if (await canLaunch('${_articles[i].link}')) {
                                await launch('${_articles[i].link}');
                              }
                            },
                          ));
                    },
                  ),
                )),
    );
  }
}
