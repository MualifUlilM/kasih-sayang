import 'package:flutter/foundation.dart';

import '../api.dart';
import '../models/api_response.dart';

class CartItem {
  int id;
  String name;
  String image;
  int price;
  int qty;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
    @required this.qty,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {
    // '11':CartItem(id: 1, name: 'Es mangut', image: 'https://awsimages.detik.net.id/community/media/visual/2019/03/08/985df401-ac19-4ed0-ae36-4bdbf5e68981_43.jpeg?w=700&q=90', price: 11000, qty: 1)
  };
  int _outletId = 0;
  String _outletName = '';
  int ship = -1;

  int get outletId {
    return outletId;
  }

  String get outletName {
    return _outletName;
  }

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int productCount(int productId) {
    int _qty = 0;
    if (_items.containsKey(productId.toString()))
      _qty = _items[productId.toString()].qty;
    return _qty;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  void addItem(
    int outletId,
    String outletName,
    int productId,
    int price,
    String name,
    String image,
    int qty
  ) {
    if (_outletId != outletId) {
      clear();
    }
    _outletId = outletId;
    _outletName = outletName;
    if (_items.containsKey(productId.toString())) {
      // change quantity...
      _items.update(
        productId.toString(),
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          image: existingCartItem.image,
          price: existingCartItem.price,
          qty: existingCartItem.qty + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId.toString(),
        () => CartItem(
          id: productId,
          image: image,
          name: name,
          price: price,
          qty: qty,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId.toString());
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId.toString())) {
      return;
    }
    if (_items[productId.toString()].qty > 1) {
      _items.update(
          productId.toString(),
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                name: existingCartItem.name,
                price: existingCartItem.price,
                image: existingCartItem.image,
                qty: existingCartItem.qty - 1,
              ));
    } else {
      _items.remove(productId.toString());
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future<ApiResponse> sendData(token, address, detailAddress, lng, lat) async {
    List<Map<String, dynamic>> _details = [];
    try {
      _items.forEach((key, val) {
        _details.add({
          "id_mx_ms_product": val.id,
          "qty": val.qty,
        });
      });

      var response = await Api().postOrder(
        token,
        _outletId,
        address,
        detailAddress,
        lng,
        lat,
        _details,
      );
      print(response.data);

      if (response.data['api_status'] == 1) {
        clear();
      }

      return ApiResponse(false, response.data);
    } catch (e) {
      return ApiResponse(true, {'message': e.toString()});
    }
  }

  Future<ApiResponse> checkShip(
    String token,
    double lat,
    double lng,
  ) async {
    try {
      var response = await Api().checkShip(
        token,
        lat,
        lng,
        this._outletId,
      );

      if (response.data['api_status'] == 1) {
        this.ship = response.data['data']['ship'];
        notifyListeners();
      }

      return ApiResponse(false, response.data);
    } catch (e) {
      return ApiResponse(true, {'message': e.toString()});
    }
  }
}
