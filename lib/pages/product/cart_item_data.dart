import 'package:flutter/material.dart';
import '../../providers/cart.dart';

class CartItemData extends StatelessWidget {
  final CartItem cart;
  bool counter;

  CartItemData({this.cart, this.counter});

  @override
  Widget build(BuildContext context) {
    return customItem(context);
  }

  Widget customItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.network(cart.image),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          cart.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Text(
                          cart.price.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                counter ? IconButton(
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: () {},
                  padding: EdgeInsets.all(0),
                ) : Container(),
                Text(cart.qty.toString() + 'X'),
                counter ? IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () {},
                  padding: EdgeInsets.all(0),
                ) : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildListtile(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Image.network(
          cart.image,
          fit: BoxFit.cover,
        ),
        width: MediaQuery.of(context).size.width * 0.1,
      ),
      title: Container(
        margin: EdgeInsets.only(right: 20),
        child: Text(cart.name),
      ),
      trailing: Text(cart.qty.toString() + "X"),
      subtitle: Text(
        (cart.qty * cart.price).toString(),
      ),
    );
  }
}
