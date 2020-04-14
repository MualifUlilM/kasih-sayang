import 'package:KasihSayang/models/drink_model.dart';
import 'package:flutter/foundation.dart';

class CartModel{
  String id;
  int qty;
  int harga;
  String name;
  String imgUrl,desc;
  
  CartModel({
    this.id,
    this.harga,
    this.qty,
    this.name,
    this.desc,
    this.imgUrl,
  });
}

class CartDrink with ChangeNotifier{
  Map<String, CartModel> items = {};

  Map<String, CartModel> get drinks{
    return {...items};
  }

  addItems(
    String idProduct,
    int harga,
    int qty,
    String name,
    String desc,
    String imgUrl,
  ){
    // items.add(drinks);
    if (items.containsKey(idProduct)) {
      items.update(idProduct, (existingCart)=>CartModel(
        id: existingCart.id,
        harga: existingCart.harga,
        name: existingCart.name,
        qty: existingCart.qty + 1,
      ));
    } else {
      items.putIfAbsent(idProduct.toString(), ()=>CartModel(
      id: DateTime.now().toString(),
      harga: harga,
      qty: qty,
      name: name,
    ));
    }
    notifyListeners();
  }

  removeItems(String id){
    items.remove(id);
    notifyListeners();
  }
}