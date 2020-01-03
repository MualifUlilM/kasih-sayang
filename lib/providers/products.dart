import 'package:flutter/foundation.dart';

import '../api.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<Map<String, dynamic>> fetchAndSet(String token, int spbuId) async {
    Map<String, dynamic> _result;
    try {
      await Api().fetchProducts(token, spbuId).then((res) {
        if (res.data['api_status'] == 1) {
          setProducts(res.data['data']);
          _result = {
            'success': true,
            'message': res.data['api_message'],
            'data': res.data['data'],
          };
        } else {
          _result = {
            'success': false,
            'message': res.data['api_message'],
          };
        }
      });
    } catch (e) {
      _result = {
        'success': false,
        'message': e.toString(),
      };
    }
    return _result;
  }

  setProducts(List products) {
    final List<Product> tmp = [];
    for (var i = 0; i < products.length; i++) {
      final product = products[i];
      tmp.add(Product(
        id: product['id'],
        description: product['description'],
        image: product['image'],
        name: product['name'],
        price: product['price'],
        stock: product['stock'],
      ));
    }
    this._products = tmp;

    notifyListeners();
  }
}

class Product {
  int id;
  String name;
  String image;
  String description;
  int stock;
  int price;

  Product({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.stock,
    @required this.price,
  });
}
