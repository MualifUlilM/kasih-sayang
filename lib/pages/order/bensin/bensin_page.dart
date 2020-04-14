import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:KasihSayang/api.dart';
import 'package:KasihSayang/assets/maxcolor.dart';
import 'package:KasihSayang/main.dart';
import 'package:KasihSayang/pages/history/riwayat.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

import '../../my_home_page.dart';
import 'package:KasihSayang/providers/user.dart';

class BensinPage extends StatefulWidget {
  static const routeName = 'bensin';
  // Position _currentLocation;
  // BensinPage(this._currentLocation);
  @override
  _BensinPageState createState() => _BensinPageState();
}

class _BensinPageState extends State<BensinPage> {
  GoogleMapController mapController;
  Set<Marker> marker = {};
  bool isLoading;
  SharedPreferences preferences;
  LatLng spbuLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userData = Provider.of<User>(context, listen: false);
    marker.add(
      Marker(
        markerId: MarkerId("User Loaction"),
        position: LatLng(
          userData.lat,
          userData.lng,
        ),
        icon: BitmapDescriptor.defaultMarker,
        // draggable: true,
      ),
    );
  }

  void _cameraUpdate() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: spbuLocation,
      zoom: 16,
    )));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    ProgressDialog pr =
        ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      progressWidget: CircularProgressIndicator(),
      borderRadius: 10,
      message: "Tunggu Sebentar...",
    );
    final userData = Provider.of<User>(context, listen: false);
    String teks = 'Order Sekarang';

    return Scaffold(
      appBar: AppBar(
        title: Text('OrderBensin'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        child: RaisedButton(
          color: MaxColor.merah,
          child: Container(
            height: 60,
            child: Center(
              child: Container(
                // height: 50,
                child: Text(
                  teks,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          onPressed: () {
            pr.show();
            Api().reqApi(
              method: 'POST',
              url: 'post_order',
              data: {
                'token': userProvider.token,
                "id_mx_ms_category_service": '3',
                'id_mx_ms_outlets': '1',
                'address': userProvider.address,
                'detail_address': 'Sint adipisicing esse ea minim excepteur.',
                'lng': userProvider.lng.toString(),
                'lat': userProvider.lat.toString(),
                "id_mx_ms_category_service": 3,
              },
            ).then((value) {
              print(value);
              // marker.add(
              //   Marker(
              //     markerId: MarkerId("User Loaction"),
              //     position: spbuLocation,
              //     icon: BitmapDescriptor.defaultMarker,
              //   ),
              // );

              // setState(() {
              //   teks = value.data['api_message'];
              //   marker.add(Marker(
              //     markerId: MarkerId("User Loaction"),
              //     position: LatLng(
              //       userData.lat,
              //       userData.lng,
              //     ),
              //     icon: BitmapDescriptor.defaultMarker,
              //   ));
              // });

              // _cameraUpdate();
              pr.hide();
              if (value.data['api_status'] != 1) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Terjadi kesalahan'),
                    content: Text(
                      '${value.data['api_message']}',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage(2)),
                    (Route<dynamic> route) => false);
              }
            });
            print('setelah');
            if (isLoading == true) {
            } else {
              isLoading = true;
            }
          },
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            userData.lat,
            userData.lng,
          ),
          zoom: 16,
        ),
        markers: marker,
      ),
    );
  }
}
