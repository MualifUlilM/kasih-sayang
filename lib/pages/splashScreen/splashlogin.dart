import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:KasihSayang/assets/maxcolor.dart';
import 'package:KasihSayang/main.dart';
import 'package:KasihSayang/models/spbu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:KasihSayang/pages/login/login.dart';
import 'package:http/http.dart' as http;

import '../my_home_page.dart';

class SplashLogin extends StatefulWidget {
  String token;
  SplashLogin(@required this.token);
  @override
  _SplashLogState createState() => _SplashLogState();
}

class _SplashLogState extends State<SplashLogin> {
  Future<SPBU> spbu;
  Position _currentPosition;
  SharedPreferences preferences;

  @override
  void initState() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
    print(_currentPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyHomePage(0),
      backgroundColor: MaxColor.merah,
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.white,
      // loadingText: Text("Aku Suka Maxiaga ...",style: TextStyle(
      //   color: Colors.white,
      //   fontSize: 20
      // ),),
    );
  }
}
