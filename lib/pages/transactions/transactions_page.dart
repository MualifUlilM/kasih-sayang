import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:KasihSayang/appBar.dart';
import 'package:KasihSayang/models/transaksi.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../providers/user.dart';
import 'package:KasihSayang/pages/history/detailriwayat.dart';
import '../../providers/transactions.dart';
import './transaction_list.dart';

class TransactionPage extends StatefulWidget {
  static const routeName = '/transactions';
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isLoading = true;

  @override
  void initState() {
    final userData = Provider.of<User>(context, listen: false);
    Provider.of<Transactions>(context, listen: false)
        .fetchAndSetData(userData.token)
        .then((res) {
      print('e');
      print(res['message']);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false);
    final transData = Provider.of<Transactions>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset(
      //     'lib/assets/images/maxiaga_putih.png',
      //     scale: 20,
      //   ),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarBikin(),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Riwayat",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Consumer<Transactions>(
              builder: (_, transactions, _2) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return TransactionList(
                    transactions.transactions,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
