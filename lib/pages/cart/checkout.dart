import 'package:KasihSayang/appBar.dart';
import 'package:KasihSayang/pages/home/outlets_around.dart';
import 'package:KasihSayang/pages/my_home_page.dart';
import 'package:KasihSayang/pages/product/cart_item_data.dart';
import 'package:KasihSayang/providers/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutPage extends StatefulWidget {
  String title;
  List<CartItem> items;

  CheckoutPage({this.title, this.items});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<Color> _colors = [
    Color(0xFFF36DB6),
    Color(0xFF52CFE1),
  ];

  String value;

  List<String> values = ['Grab', 'Gojek', 'Ambil Sendiri'];

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text("Checkout"),
        backgroundColor: AppBarBikin.colors[0],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Minuman Kamu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Column(
                children: List.generate(widget.items.length, (i) {
                  return CartItemData(cart: widget.items[i],counter: false,);
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Pengiriman",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: CarouselSlider(
                enableInfiniteScroll: false,
                onPageChanged: (index) {
                  setState(() {
                    value = values[index];
                  });
                  print(value);
                },
                height: MediaQuery.of(context).size.height * 0.2,
                items: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: _colors),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.grey,
                              blurRadius: 6),
                        ]),
                    child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/id/thumb/f/f6/Grab_Logo.svg/1200px-Grab_Logo.svg.png'),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.all(30),
                  ),
                  FlatButton(
                    onPressed: () async {
                      launch(
                          'https://play.google.com/store/apps/details?id=com.gojek.app');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: _colors),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.grey,
                                blurRadius: 6),
                          ]),
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Gojek_logo_2019.svg/1280px-Gojek_logo_2019.svg.png'),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.2,
                      padding: EdgeInsets.all(30),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: _colors),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.grey,
                              blurRadius: 6),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Ambil Sendiri",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Icon(
                          Icons.location_on,
                          size: 35,
                          color: Colors.white,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.all(30),
                  ),
                ],
              ),
            ),
            value == 'Ambil Sendiri'
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(-6.9858982, 110.4142924), zoom: 16)),
                  )
                : Container(
                    // child: Text("data"),
                    ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: RaisedButton(
                  color: AppBarBikin.colors[1],
                  onPressed: () {
                    Provider.of<Cart>(context).clear();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>MyHomePage(0)), (Route route)=>false);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text("Pesan Sekarang", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
