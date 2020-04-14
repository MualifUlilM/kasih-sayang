import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart.dart';
import '../../providers/products.dart';

class ProductItem extends StatelessWidget {
  final Product _product;
  final int _outletId;
  final String _outletName;

  ProductItem(
    this._outletId,
    this._outletName,
    this._product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(offset: Offset(1, 1), color: Colors.grey, blurRadius: 6)
          ]),
      child: FlatButton(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Image.network(
                _product.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "${_product.name}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            // SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Rp ${_product.price.toStringAsFixed(0)}",
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Container(
              child: Consumer<Cart>(
                builder: (_, cart, _2) => ActionButton(
                  spbuId: _outletId,
                  spbuName: _outletName,
                  product: _product,
                ),
              ),
            ),
          ],
        ),
        onPressed: null,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required int spbuId,
    @required String spbuName,
    @required Product product,
  })  : _outletId = spbuId,
        _outletName = spbuName,
        _product = product,
        super(key: key);

  final Product _product;
  final int _outletId;
  final String _outletName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: FlatButton(
            child: Icon(
              Icons.remove,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              Provider.of<Cart>(context, listen: false)
                  .removeSingleItem(_product.id);
            },
          ),
          width: 50,
        ),
        Text(
          Provider.of<Cart>(context).productCount(_product.id).toString(),
          textAlign: TextAlign.center,
        ),
        Container(
          child: FlatButton(
            child: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              // Provider.of<Cart>(context, listen: false).addItem(
              //   _outletId,
              //   _outletName,
              //   _product.id,
              //   _product.price,
              //   _product.name,
              //   _product.image,
              // );
            },
          ),
          width: 50,
        ),
      ],
    );
  }
}
