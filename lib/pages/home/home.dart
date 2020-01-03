import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/spbu.dart';
import './background.dart';
import './article_slider.dart';
import './buildCard.dart';
import './outlets_around.dart';
import '../../providers/outlets.dart';
import '../order/bensin/bensin_page.dart';
import '../order/servis/service_page.dart';
import '../order/ban/ban_page.dart';
import '../order/oli/oli_page.dart';
import '../../providers/articles.dart';
import '../../providers/user.dart';
import '../../providers/articles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var res;
  SharedPreferences preferences;
  String name, email, photo, token, phone, gender, kota;
  List<String> kendaraan;
  @override
  Position _currentPosition;
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  LatLng spbuPoint;
  List<SPBU> spbu;
  Background bg = Background();

  Geolocator geolocator = Geolocator();
  Position userLocation;

  @override
  void initState() {
    _refreshHome(context);
    super.initState();
  }

  Future<void> _refreshHome(BuildContext context) async {
    final userProvider = Provider.of<User>(context, listen: false);
    final outletsProvider = Provider.of<Outlets>(context, listen: false);
    final articleProvider = Provider.of<Articles>(context, listen: false);
    userProvider.checkLogin();

    articleProvider.fetchAndSet(0, 5);
    await userProvider.setLocation();
    await outletsProvider.setOutletsApi(
      userProvider.lat,
      userProvider.lng,
      userProvider.token,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshHome(context),
      child: LayoutBuilder(
        builder: (context, constrait) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constrait.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Background(),
                        BuildCard(),
                      ],
                    ),
                    Consumer<Outlets>(builder: (_, outlets, _2) {
                      return OutletsAround(outlets.outlets);
                    }),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Artikel Untuk Anda",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text('EnergiBangsa.id')
                        ],
                      ),
                    ),
                    Consumer<Articles>(
                      builder: (_, articles, _2) {
                        return ArticlesSlider(articles.articles);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
