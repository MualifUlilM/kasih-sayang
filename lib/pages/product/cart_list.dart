import 'package:flutter/material.dart';
import '../../providers/cart.dart';
import './cart_item_data.dart';
import './cart_item_full_total.dart';
import './cart_item_subtotal.dart';

class CartList extends StatelessWidget {
  final Map<String, CartItem> cartData;
  final int total;
  final int ship;

  CartList(
    this.cartData,
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
          itemCount: cartData.length == 0 ? 0 : cartData.length + 2,
          itemBuilder: (context, index) {
            if (index < cartData.length) {
              return CartItemData(cartData.values.toList()[index]);
            } else if (index == cartData.length) {
              return new CartItemSubTotal(total: total, ship: ship);
            } else {
              return new CartItemFullTotal(total: total, ship: ship);
            }
          },
        ),
      ),
    );
  }
}
