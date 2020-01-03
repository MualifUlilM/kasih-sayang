import 'package:flutter/material.dart';
import 'package:maxiaga/models/transaksi.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/transaction_detail.dart';

import './transaction_detail_header.dart';
import './transaction_detail_list.dart';
import '../../api.dart';

class TransactionDetailPage extends StatelessWidget {
  final int id;
  final String token;

  TransactionDetailPage(this.token, this.id);

  Future<TransactionDetail> _getDetailTransaction(String token, int id) async {
    var response = await Api().getTransactionDetail(token, id);
    if (response.statusCode == 200) {
      print(TransactionDetail.fromJson(response.data));
      return TransactionDetail.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  // Future _getDetailsTransaction(int id, String token) async {
  //   var res = await http.get(
  //       'http://maxiaga.com/backend/api/get_transaction_detail?id=$id&token=$token');
  //   var jsonRes;

  //   if (res.statusCode == 200) {
  //     print(jsonRes = json.decode(res.body));
  //     return jsonRes = json.decode(res.body);
  //   } else {
  //     throw Exception('Cannot Load Data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text(
            'Pesanan',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder<TransactionDetail>(
          future: _getDetailTransaction(token, id),
          builder: (context, snapshot) {
            print('snap');
            print(snapshot.data);
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TransactionHeader(snapshot.data),
                  TransactionDetailList(
                    snapshot.data,
                    snapshot.data.total,
                    snapshot.data.ship,
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
