import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:KasihSayang/providers/user.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:KasihSayang/main.dart';

import '../../../providers/user.dart';

class TambahKendaraan extends StatefulWidget {
  String token;
  Position location;
  TambahKendaraan({@required this.token, this.location});
  @override
  _TambahKendaraanState createState() => _TambahKendaraanState();
}

class _TambahKendaraanState extends State<TambahKendaraan> {
  Color color1 = Colors.red;
  Color color2 = Colors.grey[300];
  int valueKendaraan = 1;
  Image imageMotor = Image.asset(
    'lib/assets/images/motorputih.png',
    scale: 2,
  );
  Image imageMobil = Image.asset(
    'lib/assets/images/mobil.png',
    scale: 2,
  );
  TextEditingController _merkController = new TextEditingController();
  TextEditingController _brandController = new TextEditingController();
  TextEditingController _tahunController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SharedPreferences preferences;

  _postKendaraan(String jenis, String merk, String brand, String tahun,
      String token) async {
    preferences = await SharedPreferences.getInstance();
    var res = await http
        .post('http://maxiaga.com/backend/api/post_add_kendaraan', body: {
      'type': jenis,
      'merk': merk,
      'brand': brand,
      'tahun': tahun,
      'token': token,
    });
    var jsonRes;
    print(res.statusCode);
    if (res.statusCode == 200) {
      jsonRes = json.decode(res.body);
      print(jsonRes);
      preferences.setStringList(
          'kendaraan', _mapKendaraanData(jsonRes['data']));
      return jsonRes;
    } else {
      throw Exception('Cannot Post data');
    }
  }

  List<String> _mapKendaraanData(List<dynamic> kendaraan) {
    try {
      var res = kendaraan.map((v) => json.encode(v)).toList();
      return res;
    } catch (err) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);

    ProgressDialog pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

  pr.style(
      message: 'Tunggu Sebentar . . .',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Pilih Kendaraan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: color1,
                          borderRadius: BorderRadius.circular(50)),
                      child: FlatButton(
                        child: imageMotor,
                        onPressed: () {
                          setState(() {
                            color2 = Colors.grey[300];
                            imageMobil = Image.asset(
                              'lib/assets/images/mobil.png',
                              scale: 2,
                            );
                            color1 = Colors.red;
                            imageMotor = Image.asset(
                              'lib/assets/images/motorputih.png',
                              scale: 2,
                            );
                            valueKendaraan = 1;
                            print(valueKendaraan);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: color2,
                          borderRadius: BorderRadius.circular(50)),
                      child: FlatButton(
                        child: imageMobil,
                        onPressed: () {
                          setState(() {
                            color2 = Colors.red;
                            imageMobil = Image.asset(
                              'lib/assets/images/mobilputih.png',
                              scale: 2,
                            );
                            color1 = Colors.grey[300];
                            imageMotor = Image.asset(
                              'lib/assets/images/motor.png',
                              scale: 2,
                            );
                            valueKendaraan = 2;
                            print(valueKendaraan);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _merkController,
                  validator: (val) {
                    return val.isEmpty ? "Merk kosong" : null;
                  },
                  decoration:
                      InputDecoration(labelText: 'Merk', hintText: "ex: Honda"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _brandController,
                  validator: (val) {
                    return val.isEmpty ? "Brand kosong" : null;
                  },
                  decoration:
                      InputDecoration(labelText: 'Brand', hintText: "ex: Beat"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _tahunController,
                  validator: (val) {
                    return val.isEmpty ? "Tahun kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Tahun',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: "ex: 2019"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(9)),
                child: FlatButton(
                    onPressed: () {
                      pr.show();
                      userProvider.postAddKendaraan(
                          valueKendaraan,
                          _merkController.text,
                          _brandController.text,
                          _tahunController.text,
                          userProvider.token,
                      ).then((value){
                        pr.hide();
                        // if (value['success'] == true) {
                          Navigator.pop(context);
                        // }
                      });
                    },
                    child: Center(
                      child: Text("TAMBAH",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
