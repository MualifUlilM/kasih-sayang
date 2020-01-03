import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../providers/user.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> _products;
  final int outletId;
  final String outletName;
  ProductGrid(
    this.outletId,
    this.outletName,
    this._products,
  );

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context)
        .fetchAndSet(Provider.of<User>(context, listen: false).token, outletId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshProduct(context),
      child: _products.length == 0
          ? ListView.builder(
              itemCount: 1,
              itemBuilder: (_, i) => Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tidak terdapat Product di outlet ini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Seret Kebawah untuk menyegarkan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (80 / 100),
              children: List.generate(
                _products.length,
                (i) => ProductItem(
                  outletId,
                  outletName,
                  _products[i],
                ),
              ),
            ),
    );
  }
}
