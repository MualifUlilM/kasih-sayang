import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../my_home_page.dart';
import '../../providers/cart.dart';
import '../../providers/user.dart';
import './cart_list.dart';

class CartPage extends StatelessWidget {
  static const routeName = 'cart';
  final _detailAddressController = TextEditingController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    final userData = Provider.of<User>(context, listen: false);

    pr.style(
      message: 'Tunggu Sebentar . . .',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Pesanan",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Padding(
        child: FlatButton(
          highlightColor: Colors.transparent,
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Tambahkan detail'),
                content: TextField(
                  controller: _detailAddressController,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Batal'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Pesan'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      pr.show();
                      final userData =
                          Provider.of<User>(context, listen: false);
                      Provider.of<Cart>(context, listen: false)
                          .sendData(
                        userData.token,
                        userData.address,
                        _detailAddressController.text,
                        userData.lng,
                        userData.lat,
                      )
                          .then((val) {
                        pr.hide();
                        print(val.success);
                        if (!val.success) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content: Text(val.message),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                )
                              ],
                            ),
                          );
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage(2)),
                              (Route<dynamic> route) => false);
                        }
                      });
                      // Provider.of<Cart>(context).items.forEach((key, val) {
                      //   print(val.toString());
                      // });
                    },
                  ),
                ],
              ),
            );
//          Navigator.push(context, MaterialPageRoute(builder: (context)=>Pesanan()));
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Pesan Sekarang",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        padding: EdgeInsets.all(10),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          _top(context),
          Consumer<Cart>(builder: (_, cart, _2) {
            cart.checkShip(
              userData.token,
              userData.lat,
              userData.lng,
            );

            if (cart.ship < 0) {
              return Flexible(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return CartList(cart.items, cart.totalAmount, cart.ship);
            }
          }),
        ],
      ),
    );
  }

  Container _top(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pesananmu dari : " +
                  Provider.of<Cart>(context, listen: false).outletName,
              style: Theme.of(context).primaryTextTheme.title,
              maxLines: 2,
            ),
            Text(
              "Akan diantar ke : " +
                  Provider.of<User>(context, listen: false).address,
              style: Theme.of(context).primaryTextTheme.title,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
