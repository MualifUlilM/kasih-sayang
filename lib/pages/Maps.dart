import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:KasihSayang/models/spbu.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class Maps extends StatefulWidget {
  // Position location;
  // Maps({Key key, @required this.location}) : super(key: key);
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController;
  Position _currentPosition;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    // refresh location
    Provider.of<User>(context, listen: false).setLocation();
    // add marker
    _markers.add(
      Marker(
        markerId: MarkerId("user location"),
        position: LatLng(Provider.of<User>(context, listen: false).lat,
            Provider.of<User>(context, listen: false).lng),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var userLocation = Provider.of<UserLocation>(context);
    LatLng _center =
        LatLng(Provider.of<User>(context).lat, Provider.of<User>(context).lng);

    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'lib/assets/images/maxiaga_putih.png',
            scale: 20,
          ),
        ),
        body: GoogleMap(
          compassEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          markers: _markers,
        ));
  }
}
