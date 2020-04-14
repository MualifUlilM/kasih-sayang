import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:KasihSayang/appBar.dart';
import 'package:KasihSayang/pages/product/add_story.dart';
import 'package:KasihSayang/providers/sosmed.dart';
import 'package:provider/provider.dart';

import 'package:KasihSayang/pages/history/riwayat.dart';
import '../../providers/outlets.dart';
import '../../providers/user.dart';
import './outlet_card.dart';

class ProductPage extends StatelessWidget {
  Future<void> _refreshOutlets(BuildContext context) async {
    final userProvider = Provider.of<User>(context, listen: false);
    final outletProvider = Provider.of<Outlets>(context, listen: false);
    await outletProvider.setOutletsApi(
        userProvider.lat, userProvider.lng, userProvider.token);
  }

  @override
  Widget build(BuildContext context) {
    final outletProvider = Provider.of<Outlets>(context);
    final _outlets = outletProvider.outlets;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();
    final sosmedProvider = Provider.of<Sosmed>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPost.routingName);
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.102,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Cerita',
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        IconButton(icon: Icon(Icons.filter_list), onPressed: (){})
                      ],
                    ),
                  ),
                  Consumer<Sosmed>(builder: (_, sosmed, _2) {
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(sosmed.posts.length, (i) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 1),
                            // color: Colors.blue,
                            // height: MediaQuery.of(context).size.height * 0.15,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.pink,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${sosmed.posts[i].name}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  child: sosmed.posts[i].imageUrl != null
                                      ? Image.network(sosmed.posts[i].imageUrl)
                                      : Container(),
                                ),
                                SizedBox(
                                  // height: MediaQuery.of(context).size.height * 0.4,
                                  child: sosmed.posts[i].imageFile != null
                                      ? Container(child: Image.file(sosmed.posts[i].imageFile,), height: MediaQuery.of(context).size.height * 0.4,)
                                      : Container(),
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        ),
                                        onPressed: () {}),
                                    Text("4.5K"),
                                    IconButton(
                                        icon: Icon(
                                          Icons.comment,
                                          color: Colors.pink,
                                        ),
                                        onPressed: () {}),
                                    Text("5K"),
                                    IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.pink,
                                        ),
                                        onPressed: () {}),
                                    Text("2K"),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    sosmed.posts[i].caption,
                                    style: TextStyle(fontSize: 18),
                                    // textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          AppBarBikin(),
        ],
      ),
    );
  }
}
