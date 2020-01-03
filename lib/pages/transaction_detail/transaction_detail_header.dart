import 'package:flutter/material.dart';

import '../../models/transaction_detail.dart';

class TransactionHeader extends StatelessWidget {
  final TransactionDetail transaction;

  TransactionHeader(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3.5,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (transaction.invoice != '0')
            Container(
              child: Text('Invoice : ${transaction.invoice}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  maxLines: 1),
              padding: EdgeInsets.all(10),
            ),
          Container(
            child: transaction.outletName == null
                ? Text(
                    'Pesananmu dari : Menuggu',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 1,
                  )
                : Text(
                    'Pesananmu dari : ${transaction.outletName}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 1,
                  ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: Text('Akan di antar ke : ${transaction.address}',
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 1),
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: Text('Status : ${transaction.status}',
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 1),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
