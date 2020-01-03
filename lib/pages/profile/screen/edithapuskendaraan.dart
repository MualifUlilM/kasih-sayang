import 'package:flutter/material.dart';
import 'package:maxiaga/pages/profile/profile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';

class EditRemoveKendaraan extends StatefulWidget {
  static const routingName = 'editRemoveKendaraan';
  int type;
  String brand, merk, tahun;
  Kendaraan kendaraan;
  EditRemoveKendaraan({this.kendaraan});
  @override
  _EditRemoveKendaraanState createState() => _EditRemoveKendaraanState();
}

class _EditRemoveKendaraanState extends State<EditRemoveKendaraan> {
  TextEditingController brand = TextEditingController();
  TextEditingController merk = TextEditingController();
  TextEditingController tahun = TextEditingController();
  int type;

  final _formKey = GlobalKey<FormState>();

  Color color1 = Colors.red;
  Color color2 = Colors.grey[300];

  Image imageMotor = Image.asset(
    'lib/assets/images/motorputih.png',
    scale: 2,
  );
  Image imageMobil = Image.asset(
    'lib/assets/images/mobil.png',
    scale: 2,
  );

  void setInitial() {
    type = widget.kendaraan.typeId;
    brand.text = widget.kendaraan.brand;
    merk.text = widget.kendaraan.merk;
    tahun.text = widget.kendaraan.tahun;

    if (type == 2) {
      setState(() {
        imageMotor = Image.asset(
          'lib/assets/images/motor.png',
          scale: 2,
        );
        imageMobil = Image.asset(
          'lib/assets/images/mobilputih.png',
          scale: 2,
        );
        color1 = Colors.grey[300];
        color2 = Colors.red;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitial();
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<User>(
      context,
    );

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
        title: Text('Edit Kendaraan'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Hapus',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Hapus Kendaraan?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                              'Anda Yakin Ingin Menghapus Kendaran ${widget.kendaraan.brand} ?'),
                          // Text('You\’re like me. I’m never satisfied.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ya'),
                        onPressed: () async {
                          userdata
                              .getDeleteKendaraa(
                                  widget.kendaraan.id, userdata.token)
                              .then((onValue) {
                                print(onValue);
                                // Navigator.popUntil(context, ModalRoute.withName(Profile.routingName));
                                Navigator.of(context,rootNavigator: false).pop();
                                // Navigator.pushReplacementNamed(context, Profile.routingName);
                          }).then((onValue){
                            Navigator.pop(context);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text('Tidak'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              // Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
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
                            type = 1;
                            // print(valueKendaraan);
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
                            type = 2;
                            // print(valueKendaraan);
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
                  controller: merk,
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
                  controller: brand,
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
                  controller: tahun,
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
                width: MediaQuery.of(context).size.width * 0.5,
                // alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(9)),
                child: FlatButton(
                    onPressed: () {
                      pr.show();
                      userdata
                          .postEditKendaraan(
                        widget.kendaraan.id,
                        type,
                        merk.text,
                        brand.text,
                        tahun.text,
                      )
                          .then((onValue) {
                        print(onValue);
                        pr.hide();
                        Navigator.pop(context);
                      });
                    },
                    child: Center(
                      child: Text("Simpan",
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
