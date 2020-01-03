import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../providers/outlets.dart';
import '../../providers/outlet.dart';
import './outlet_card.dart';

class OutletsAround extends StatefulWidget {
  final List<Outlet> outlets;
  OutletsAround(this.outlets);

  @override
  _OutletsAroundState createState() => _OutletsAroundState();
}

class _OutletsAroundState extends State<OutletsAround> {
  Set<Marker> _markers = {};

  GoogleMapController mapController;

  LatLng spbuPoint;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _cameraUpdate(LatLng pointSpbu) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: pointSpbu,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  void initState() {
    for (var i = widget.outlets.length - 1; i >= 0; i--) {
      setState(() {
        _markers.add(
          Marker(
              markerId: MarkerId("${widget.outlets[i].name}"),
              position: LatLng(widget.outlets[i].lat, widget.outlets[i].lng),
              icon: BitmapDescriptor.defaultMarker),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _outlets = widget.outlets;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 2.0), blurRadius: 6)
        ],
      ),
      // color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 30),
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Outlet Terdekat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                if (_outlets.length > 0)
                  GoogleMap(
                    compassEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_outlets[0].lat, _outlets[0].lng),
                      zoom: 16.0,
                    ),
                    markers: _markers,
                  ),
                if (_outlets.length < 1)
                  Center(
                    child: Text(
                        'Maaf Kami Tidak Dapat Menemukan Spbu Disekitar anda'),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 80),
                  child: CarouselSlider(
                    onPageChanged: (index) {
                      setState(() {
                        spbuPoint =
                            LatLng(_outlets[index].lat, _outlets[index].lng);
                      });
                      _cameraUpdate(spbuPoint);
                    },
                    enableInfiniteScroll: false,
                    items: List.generate(
                      _outlets.length,
                      (i) => Container(
                        height: 50,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 90, 10, 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(2, 3),
                                    blurRadius: 6),
                              ]),
                          child: OutletCard(_outlets[i]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
