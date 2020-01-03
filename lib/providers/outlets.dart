import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import './outlet.dart';

class Outlets with ChangeNotifier {
  Dio dio = Dio();
  Response response;

  List<Outlet> _items = [];

  List<Outlet> get outlets {
    return [..._items];
  }

  Future<bool> setOutletsApi(double lat, double lng, String token) async {
    response = await Api().reqApi(
      method: 'GET',
      url: 'get_spbu',
      queryParameters: {
        "lng": lng,
        "lat": lat,
        "token": token,
      },
    );

    if (response.data['api_status'] == 1) {
      setOutlets(response.data['data']);
    }

    return true;
  }

  setOutlets(List outlets) {
    final List<Outlet> tmp = [];
    for (var i = 0; i < outlets.length; i++) {
      var outlet = outlets[i];
      tmp.add(Outlet(
        id: outlet['id'],
        name: outlet['name'],
        address: outlet['address'],
        lng: double.parse(outlet['lng']),
        lat: double.parse(outlet['lat']),
        distance: outlet['distance'],
        idProvince: outlet['id_province'],
        idRegency: outlet['id_regency'],
        idDistrict: outlet['id_district'],
        isService: outlet['is_service'],
        isFuel: outlet['is_fuel'],
        isOil: outlet['is_oil'],
        isTire: outlet['is_tire'],
      ));
    }
    this._items = tmp;

    notifyListeners();
  }
}
