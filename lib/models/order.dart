import 'package:flutter/foundation.dart';

class Order {
  int id;
  int idProduct;
  String name;
  int price;
  int qty;
  int subtotal;

  Order({
    @required this.id,
    this.idProduct,
    @required this.name,
    @required this.price,
    @required this.qty,
    @required this.subtotal,
  });
}
