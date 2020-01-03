import 'package:flutter/material.dart';

class CartItemSubTotal extends StatelessWidget {
  const CartItemSubTotal({
    Key key,
    @required this.total,
    @required this.ship,
  }) : super(key: key);

  final int total;
  final int ship;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Total :',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          trailing: Text(total.toString()),
        ),
        ListTile(
          title: Text(
            'Biaya Pengantaran :',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          trailing: Text(ship.toString()),
        ),
      ],
    );
  }
}
