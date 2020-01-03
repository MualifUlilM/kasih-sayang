import 'package:flutter/material.dart';
import '../../providers/cart.dart';

class CartItemData extends StatelessWidget {
  final CartItem cart;

  CartItemData(this.cart);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          cart.qty.toString() + 'x',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      title: Container(
        margin: EdgeInsets.only(right: 20),
        child: Text(cart.name),
      ),
      trailing: Text(
        (cart.qty * cart.price).toString(),
      ),
    );
  }
}
