import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import './outlets.dart';
import '../api.dart';

class User with ChangeNotifier {
  Dio dio = Dio();
  Response response;
  SharedPreferences prefs;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String token;
  String name;
  String photo;
  String email;
  String phone;
  String gender;
  double lng = 0.0;
  double lat = 0.0;
  String address;
  String kota;
  List<Kendaraan> kendaraan = [];

  User() {
    print(token);
    if (this.token == null) {
      this.checkLogin();
    }
  }

  String get getToken {
    return this.token;
  }

  Future<Map<String, dynamic>> checkLogin() async {
    print('check login executed');
    try {
      prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      print(prefs.getString("token"));
      // prefs.clear();

      if (prefs.getString("token") != null) {
        token = prefs.getString("token");
        response = await Api().checkLogin(
          token,
          this.lng,
          this.lat,
        );

        await setLocation();

        if (response.data['api_status'] == 1) {
          final data = response.data;
          final kendaraanData = data['kendaraan'];
          List<Kendaraan> _tmpKendaraan = [];
          for (var i = 0; i < kendaraanData.length; i++) {
            _tmpKendaraan.add(Kendaraan(
              id: int.parse(kendaraanData[i]['id'].toString()),
              brand: kendaraanData[i]['brand'],
              merk: kendaraanData[i]['merk'],
              tahun: kendaraanData[i]['tahun'].toString(),
              type: kendaraanData[i]['type'] == 1 ? "motor" : "mobil",
              typeId: int.parse(kendaraanData[i]['type']),
            ));
          }

          email = data['email'];
          token = data['token'];
          name = data['name'];
          photo = data['photo'];
          kota = data['kota'];
          phone = data['phone'];
          gender = data['gender'];
          kendaraan = _tmpKendaraan;
          prefs.setString("token", data['token']);

          print(kota);
          print(address);

          notifyListeners();
          return {
            'success': true,
            'message': response.data['api_message'],
            'data': data['outlets'],
          };
        } else {
          return {
            'success': false,
            'message': response.data['api_message'],
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Token invalid',
        };
      }
    } on DioError catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
      ;
    }
  }

  Future<void> setLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      this.lng = position.longitude;
      this.lat = position.latitude;
    }).catchError((e) {
      print(e);
    });

    var _address = await Geocoder.local
        .findAddressesFromCoordinates(Coordinates(this.lat, this.lng));
    this.address = _address.first.addressLine;
  }

  Future<Map<String, dynamic>> signIn(
    String email,
    String password,
  ) async {
    try {
      await setLocation();

      response = await Api().reqApi(
        method: 'POST',
        url: 'post_login',
        data: {
          "email": email,
          "password": password,
          "lng": this.lng,
          "lat": this.lat,
        },
      );
      print(response);
      if (response.data['api_status'] == 1) {
        final data = response.data;
        final kendaraanData = data['kendaraan'];
        List<Kendaraan> _tmpKendaraan = [];

        for (var i = 0; i < kendaraanData.length; i++) {
          _tmpKendaraan.add(Kendaraan(
            id: int.parse(kendaraanData[i]['id'].toString()),
            brand: kendaraanData[i]['brand'],
            merk: kendaraanData[i]['merk'],
            tahun: kendaraanData[i]['tahun'].toString(),
            type: kendaraanData[i]['type'] == 1 ? "motor" : "mobil",
            typeId: int.parse(kendaraanData[i]['type']),
          ));
        }

        email = data['email'];
        token = data['token'];
        name = data['name'];
        photo = data['photo'];
        phone = data['phone'];
        kota = data['kota'];
        gender = data['gender'];
        kendaraan = _tmpKendaraan;

        prefs = await SharedPreferences.getInstance();
        prefs.setString("token", data['token']);

        return {
          'success': true,
          'message': 'Berhasil Login',
        };
      } else {
        return {
          'success': false,
          'message': response.data['api_message'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Response> logout() async {
    response = await Api().reqApi(
      method: 'POST',
      url: 'post_logout',
      data: {
        "token":this.token,
      }
    );
    
    if (response.data['api_status'] == 1) {
      prefs = await SharedPreferences.getInstance();
    prefs.clear();
    this.token = null;
    print(prefs.getString('token'));
    notifyListeners();
    return response;
    }
    return response;
  }

  void getKendaraan() {
    for (var item in kendaraan) {
      print('${item.id} - ${item.brand} - ${item.merk} - ${item.tahun}');
    }
  }

  Future<Kendaraan> postAddKendaraan(
    int id,
    String merk,
    String brand,
    String tahun,
    String token,
  ) async {
    response =
        await Api().reqApi(method: 'POST', url: 'post_add_kendaraan', data: {
      'type': id,
      'merk': merk,
      'brand': brand,
      'tahun': tahun,
      'token': token,
    });
    
    print(response);
    final data = response.data;
    List<Kendaraan> _tmpKendaraan = [];
    print('kendaraan : $data');
    // for (var i = 0; i < data.length; i++) {
    //   _tmpKendaraan.add(Kendaraan(
    //     id: int.parse(data[i]['id'].toString()),
    //     brand: data[i]['brand'],
    //     merk: data[i]['brand'],
    //     tahun: data[i]['tahun'].toString(),
    //     type: data[i]['type'] == 1 ? "motor" : "mobil",
    //     typeId: int.parse(data[i]['type']),
    //   ));
    // }
    // kendaraan = _tmpKendaraan;
    notifyListeners();
    print('memanggil checklogin');
    this.checkLogin();
    print(response.data);
  }

  Future postEditProfile(
    String token,
    String name,
    File photo,
    String email,
    String phone,
    String kota,
    String password,
  )async{
    if (password.isNotEmpty && photo != null) {
        print('condition 1');
        response =
            await Api().reqApi(method: 'POST', url: 'post_edit_profile', data: {
          "token": token,
          "name": name,
          "photo": await MultipartFile.fromFile(
            photo.path,
            filename: "gambarprofile.jpg",
          ),
          "phone": phone,
          "email": email,
          "kota": kota,
          "password": password,
        });
      } else if (photo != null) {
        print('condition 2');
        print(photo);
        response =
            await Api().reqApi(method: 'POST', url: 'post_edit_profile', data: {
          "token": token,
          "name": name,
          "photo": await MultipartFile.fromFile(
            photo.path,
            filename: "gambarprofile.jpg",
          ),
          "phone": phone,
          "email": email,
          "kota": kota,
          // "password": password,
        });
      } else if (password.isNotEmpty) {
        print('condition 3');
        response =
            await Api().reqApi(method: 'POST', url: 'post_edit_profile', data: {
          "token": token,
          "name": name,
          //   "photo": await MultipartFile.fromFile(
          //   photo.path,
          //   filename: "gambarprofile.jpg",
          // ),
          "phone": phone,
          "email": email,
          "kota": kota,
          "password": password,
        });
      } else {
        print('condition 4');
        response =
            await Api().reqApi(method: 'POST', url: 'post_edit_profile', data: {
          "token": token,
          "name": name,
          //   "photo": await MultipartFile.fromFile(
          //   photo.path,
          //   filename: "gambarprofile.jpg",
          // ),
          "phone": phone,
          "email": email,
          "kota": kota,
          // "password": password,
        });
      }
      print(response);
      this.checkLogin();
      notifyListeners();
  }

  Future<Kendaraan> postEditKendaraan(
    int id,
    int type,
    String merk,
    String brand,
    String tahun,
  )async{
    response = await Api().reqApi(
      method: 'POST',
      url: 'post_edit_kendaraan',
      data: {
        'id': id,
        'type': type,
        'merk': merk,
        'brand': brand,
        'tahun': tahun,
        'token': token,
      }
    );
    print(response);
    this.checkLogin();
    notifyListeners();
  }

  Future getDeleteKendaraa(int id, String token)async{
    response = await Api().reqApi(
      method: 'GET',
      url: 'delete_kendaraan',
      queryParameters: {
        'id': id,
        'token': token,
      }
    );
    print(response);
    this.checkLogin();
    notifyListeners();
  }

}

class Kendaraan {
  final int id;
  final int typeId;
  final String type;
  final String merk;
  final String brand;
  final String tahun;

  Kendaraan({
    this.id,
    this.typeId,
    this.brand,
    this.merk,
    this.tahun,
    this.type,
  });
}
