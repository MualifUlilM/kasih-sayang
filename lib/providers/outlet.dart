import 'package:flutter/material.dart';

class Outlet with ChangeNotifier {
  int id;
  String name;
  String address;
  double lng;
  double lat;
  String idProvince;
  String idRegency;
  String idDistrict;
  double distance;
  int isService;
  int isOil;
  int isFuel;
  int isTire;

  Outlet({
    this.id,
    this.name,
    this.address,
    this.lng,
    this.lat,
    this.idProvince,
    this.idRegency,
    this.idDistrict,
    this.distance,
    this.isService,
    this.isOil,
    this.isFuel,
    this.isTire,
  });
}
