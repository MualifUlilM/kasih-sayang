import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'buttonBan.dart';
import 'package:KasihSayang/providers/user.dart';

class BanPage extends StatefulWidget {
  static const routeName = 'ban';
  // Position _currentLocation;
  // String token;
  // BanPage(@required this._currentLocation, @required this.token);
  @override
  _BanPageState createState() => _BanPageState();
}

class _BanPageState extends State<BanPage> {
  @override
  GoogleMapController mapcontroller;
  Set<Marker> _marker = {};
  ButtonBan button = ButtonBan();

  @override
  void initState() {
    final userData = Provider.of<User>(context, listen: false);
    super.initState();
    setState(() {
      _marker.add(
        Marker(
            markerId: MarkerId('User Location'),
            position: LatLng(userData.lat, userData.lng),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapcontroller = controller;
  }

  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tambal Ban'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: button.buildButtonBan(context, 4, userData.lng, userData.lat,
            userData.token, 'Tambal Ban'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(userData.lat, userData.lng),
          zoom: 16,
        ),
        markers: _marker,
      ),
    );
  }

  Row _buildButton(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // button.buildButtonBan(context, 4, userData.lng, userData.lat,
        //     userData.token, 'Ganti Ban'),
        button.buildButtonBan(context, 4, userData.lng, userData.lat,
            userData.token, 'Tambal Ban'),
      ],
    );
  }
}
