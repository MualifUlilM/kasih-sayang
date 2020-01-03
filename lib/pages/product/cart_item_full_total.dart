import 'package:flutter/material.dart';

class CartItemFullTotal extends StatelessWidget {
  const CartItemFullTotal({
    Key key,
    @required this.total,
    @required this.ship,
  }) : super(key: key);

  final int total;
  final int ship;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: ListTile(
        title: Text(
          'TOTAL :',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        trailing: Text((total + ship).toString()),
      ),
    );
  }
}
