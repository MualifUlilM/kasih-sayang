import 'dart:convert';
import 'dart:async';
// import 'dart:html';

import 'package:KasihSayang/pages/cart/checkout.dart';
import 'package:KasihSayang/providers/cart_drink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:KasihSayang/assets/maxcolor.dart';
//import 'package:KasihSayang/models/userdata.dart';
// import 'package:KasihSayang/models/kendaraan.dart';
import 'package:KasihSayang/pages/home/home.dart';
import 'package:KasihSayang/pages/login/login.dart';
import 'package:KasihSayang/pages/history/riwayat.dart';
import 'package:KasihSayang/pages/login/loginpage.dart' as prefix0;
import 'package:KasihSayang/pages/lupa_password/lupa_password_page.dart';
import 'package:KasihSayang/pages/product/add_story.dart';
import 'package:KasihSayang/pages/product/product.dart';
import 'package:KasihSayang/pages/konsultasi/konsultasi.dart';
import 'package:KasihSayang/pages/profile/profile.dart';
import 'package:KasihSayang/providers/sosmed.dart';
import 'package:KasihSayang/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:KasihSayang/models/spbu.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import './pages/splash.dart';
import './pages/order/bensin/bensin_page.dart';
import './pages/order/servis/service_page.dart';
import './pages/order/ban/ban_page.dart';
import './pages/order/oli/oli_page.dart';
import './pages/product/cart.dart';
import './pages/transactions/transactions_page.dart';

import './providers/outlets.dart';
import './providers/articles.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Map<int, Color> color = {
    50: Color.fromRGBO(210, 34, 34, .1),
    100: Color.fromRGBO(210, 34, 34, .2),
    200: Color.fromRGBO(210, 34, 34, .3),
    300: Color.fromRGBO(210, 34, 34, .4),
    400: Color.fromRGBO(210, 34, 34, .5),
    500: Color.fromRGBO(210, 34, 34, .6),
    600: Color.fromRGBO(210, 34, 34, .7),
    700: Color.fromRGBO(210, 34, 34, .8),
    800: Color.fromRGBO(210, 34, 34, .9),
    900: Color.fromRGBO(210, 34, 34, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        ),
        ChangeNotifierProvider.value(
          value: Outlets(),
        ),
        ChangeNotifierProvider.value(
          value: Articles(),
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Transactions(),
        ),
        ChangeNotifierProvider.value(
          value: Sosmed(),
        ),
        ChangeNotifierProvider.value(value: CartDrink()),
      ],
      child: MaterialApp(
        title: 'KasihSayang',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          // primarySwatch: MaterialColor(0xFFD22222, color),
          // primaryColor: MaxColor.merah,
          primaryColor: Colors.pink,
          canvasColor: Colors.white,
          // primaryColor: MaterialColor(0xFFD22222, color),
        ),
        home: Splash(),
        routes: {
          ServicePage.routeName: (ctx) => ServicePage(),
          OliPage.routeName: (ctx) => OliPage(),
          BensinPage.routeName: (ctx) => BensinPage(),
          BanPage.routeName: (ctx) => BanPage(),
          CartPage.routeName: (ctx) => CartPage(),
          TransactionPage.routeName: (ctx) => TransactionPage(),
          Profile.routingName: (ctx) => Profile(),
          ForgotPasswordPage.routingName: (ctx) => ForgotPasswordPage(),
          AddPost.routingName: (ctx)=> AddPost(),
          // CheckoutPage.routingName: (ctx)=>CheckoutPage(),
        },
      ),
    );
  }
}
