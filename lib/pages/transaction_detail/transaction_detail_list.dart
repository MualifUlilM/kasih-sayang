import 'package:flutter/material.dart';

import '../../models/transaction_detail.dart';
import './transaction_detail_item.dart';
import './transaction_detail_full_total.dart';
import './transaction_detail_subtotal.dart';

class TransactionDetailList extends StatelessWidget {
  final TransactionDetail transaction;
  final int total;
  final int ship;

  TransactionDetailList(
    this.transaction,
    this.total,
    this.ship,
  );

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(35),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
              color: Colors.black,
            );
          },
          itemCount:
              transaction.order.length == 0 ? 0 : transaction.order.length + 2,
          itemBuilder: (context, index) {
            if (index < transaction.order.length) {
              return TransactionDetailItem(transaction.order[index]);
            } else if (index == transaction.order.length) {
              return TransactionDetailSubTotal(total: total, ship: ship);
            } else {
              return TransactionDetailFullTotal(total: total, ship: ship);
            }
          },
        ),
      ),
    );
  }
}
