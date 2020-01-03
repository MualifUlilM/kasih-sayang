import 'package:flutter/material.dart';
import '../../models/order.dart';

class TransactionDetailItem extends StatelessWidget {
  final Order order;

  TransactionDetailItem(this.order);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          order.qty.toString() + 'x',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      title: Container(
        margin: EdgeInsets.only(right: 20),
        child: Text(order.name),
      ),
      trailing: Text(
        (order.qty * order.price).toString(),
      ),
    );
  }
}
