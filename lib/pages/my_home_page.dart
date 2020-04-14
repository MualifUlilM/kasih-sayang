import 'package:KasihSayang/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import './login/login.dart';
import './home/home.dart';
import './product/product.dart';
import './history/riwayat.dart';
import './konsultasi/konsultasi.dart';
import './../assets/maxcolor.dart';
import '../providers/outlets.dart';
import './transactions/transactions_page.dart';

class MyHomePage extends StatefulWidget {
  final int index;
  MyHomePage(this.index);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final userData = Provider.of<User>(context, listen: false);
    final outletsData = Provider.of<Outlets>(context, listen: false);

    userData.checkLogin().then((res) {
      if (res['success']) {
        outletsData.setOutlets(res['data']);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
            (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: widget.index == null ? 0 : widget.index,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            ProductPage(),
            // Riwayat(),
            CartPage(),
            TransactionPage(),
            Konsultasi(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //     topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey, offset: Offset(0, -0.5), blurRadius: 6)
              ]),
          padding: EdgeInsets.all(5),
          child: new TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.apps),
              ),
              Tab(
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.chat),
              ),
            ],
            unselectedLabelColor: Colors.black,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
