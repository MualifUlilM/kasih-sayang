import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:maxiaga/pages/history/riwayat.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/maxiaga_putih.png',
          scale: 20,
        ),

        centerTitle: true,
        elevation: 0.0,
        // backgroundColor: Colors.,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "Produk",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              "Outlet terdekat",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _refreshOutlets(context),
              child: _outlets.length == 0
                  ? ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, i) => Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Tidak Terdapat SPBU di sekitar anda',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Seret Kebawah untuk menyegarkan',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, v) => Divider(
                        color: Colors.grey,
                      ),
                      itemCount: _outlets.length,
                      itemBuilder: (_, i) => OutletCard(_outlets[i]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
