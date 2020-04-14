import 'package:KasihSayang/appBar.dart';
import 'package:KasihSayang/pages/cart/checkout.dart';
import 'package:KasihSayang/pages/product/cart_item_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:KasihSayang/providers/cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int total = 0;
  @override
  Widget build(BuildContext context) {
    final drinkProvider = Provider.of<Cart>(context);
    for (var i = 0; i < drinkProvider.itemCount; i++) {
      total += drinkProvider.items.values.toList()[i].price * drinkProvider.items.values.toList()[i].qty;
      print("price = total");
    }
    print(drinkProvider.items);
    return Scaffold(
      floatingActionButton: drinkProvider.itemCount > 0
          ? Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.09,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Colors.grey,
              border: Border(top: BorderSide(width: 0.5, color: Colors.grey))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text('Total Harga Rp ${total}', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                  ),),
                ),
                RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CheckoutPage(title: 'Checkout',items: drinkProvider.items.values.toList(),)));
                },
                color: Color(0xFFF36DB6),
                child: Text('Beli ${drinkProvider.itemCount}', style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),),)
              ],
            ),
          )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          AppBarBikin(),
          Expanded(
            child: drinkProvider.itemCount > 0
                ? Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.09),
                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return Dismissible(
                            key: Key(drinkProvider.items[i].toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  semanticLabel: 'Hapus Produk Ini',
                                ),
                              ),
                            ),
                            onDismissed: (directions) {
                              // drinkProvider.removeItem(drinkProvider.items[i].id);
                              drinkProvider.removeItem(
                                  drinkProvider.items.values.toList()[i].id);
                            },
                            child: CartItemData(cart: drinkProvider.items.values.toList()[i], counter: true,));
                      },
                      separatorBuilder: (context, i) => Divider(),
                      itemCount: drinkProvider.itemCount),
                )
                : Center(
                    child: Text(
                      'Kamu belum menambahkan minuman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
