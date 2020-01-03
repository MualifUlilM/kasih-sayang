import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:maxiaga/models/spbu.dart';
import 'package:maxiaga/pages/Maps.dart';
import 'package:maxiaga/service/post/post.dart';

import '../../my_home_page.dart';
import '../../../providers/user.dart';
import '../../../providers/outlets.dart';
import '../../../providers/outlet.dart';
import '../../../models/orders.dart';
import '../../transactions/transactions_page.dart';

class ServicePage extends StatefulWidget {
  static const routeName = 'service';

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  // File file;
  // Post post = Post();
  // var kendaraan;
  // String kendaraaneSelected = "Pilih Kendaraan";
  // List _kendaraan;
  // String type;
  // int idOutlet;
  Dio dio = new Dio();
  final _form = new GlobalKey<FormState>();
  int _outletSelected;
  int _kendaraanSelected;
  List<String> _images = [];
  double _widthScreen;
  String _detailAddress;
  String _complaint = '';
  String _address = '';
  double _lng = 0.0;
  double _lat = 0.0;
  ProgressDialog pr;

  @override
  void initState() {
    final userData = Provider.of<User>(context, listen: false);
    setState(() {
      _address = userData.address;
      _lat = userData.lat;
      _lng = userData.lng;
    });
    super.initState();
  }
  // String urlPhoto;

  postImage(File image, String token) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image.path,
        filename: "gambar",
      ),
      'token': token,
    });

    var res = await dio.post(
        'http://admin.maxiaga.com/api/upload_photo_service',
        data: formData);

    if (res.statusCode == 200) {
      if (res.data['api_status'] == 1) {
        return res.data['file'];
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Terjadi kesalahan'),
            content: Text(
              res.data['api_message'],
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
        return false;
      }
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Terjadi kesalahan'),
          content: Text(
            'Error',
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
      throw Exception('cannot load data');
    }
  }

  Future submitData(String token) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    pr.show();

    Orders(
      idOutlet: _outletSelected,
      complaint: _complaint,
      detailAddress: _detailAddress,
      idCategory: 1,
      idKendaraan: _kendaraanSelected,
      photos: _images,
      address: _address,
      lat: _lat,
      lng: _lng,
      token: token,
    ).submitServices().then((val) {
      pr.hide();
      if (val['success']) {
        Navigator.of(context).pushReplacementNamed(TransactionPage.routeName);
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Terjadi kesalahan'),
            content: Text(
              val['message'],
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _widthScreen = MediaQuery.of(context).size.width;
    pr = new ProgressDialog(
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
          'Servis',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              submitData(Provider.of<User>(context, listen: false).token);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                _buildMyLocation(context),
                Consumer<Outlets>(
                  builder: (_, outlets, _2) =>
                      _buildOutletsDropdown(outlets.outlets),
                ),
                Consumer<User>(
                  builder: (_, user, _2) =>
                      _buildKendaraanDropDown(user.kendaraan),
                ),
                _buildDetailAddress(),
                _buildComplaint(),
                _buildAddImage(Provider.of<User>(context, listen: false).token),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage(String token) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 78);
    // return image;
    if (image != null) {
      //
      pr.show();
      postImage(image, token).then((val) {
        // loading finish
        pr.hide();

        if (val != false) {
          setState(() {
            _images.add(val);
          });
        }
      });
    }
  }

  Align _buildSubmitButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        height: 60,
        width: 120,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: FlatButton(
          child: Center(
            child: Text("Kirim",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          onPressed: () {
            submitData(Provider.of<User>(context, listen: false).token);
          },
          // onPressed: () => postService(
          //     userData.lng,
          //     userData.lat,
          //     _addController.text,
          //     complaintController.text,
          //     urlPhoto,
          //     userData.token,
          //     idOutlet,
          //     context),
        ),
      ),
    );
  }

  Row _buildCamera(String token) {
    return Row(
      children: <Widget>[
        ..._images.map((_file) {
          print(_file);
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: _widthScreen / 24,
            ),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
              // image: DecorationImage(
              //   image: FileImage(_file),
              // ),
            ),
            child: Center(
              child: Image.network(
                _file,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
        if (_images.length < 3)
          InkWell(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                )),
            onTap: () {
              getImage(token);
            },
          ),
      ],
    );
  }

  Container _buildAddImage(String token) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tambah Gambar",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildCamera(token),
        ],
      ),
    );
  }

  Container _buildComplaint() {
    return Container(
      height: 120,
      decoration: BoxDecoration(color: Colors.grey[300]),
      padding: EdgeInsets.only(top: 5, left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment(0.0, 0.0),
      child: TextFormField(
        maxLines: 100,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.grey[300],
          hintText: 'Keluhan',
        ),
        style: TextStyle(fontSize: 18),
        validator: (val) {
          if (val.isEmpty) {
            return "Harap isi keluhan anda";
          }
          return null;
        },
        onSaved: (val) {
          setState(() {
            _complaint = val;
          });
        },
      ),
    );
  }

  Container _buildDetailAddress() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.grey[300]),
      padding: EdgeInsets.only(top: 5, left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 15),
      alignment: Alignment(0.0, 0.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.grey[300],
          hintText: 'Alamat Detail',
        ),
        onSaved: (val) {
          setState(() {
            _detailAddress = val;
          });
        },
      ),
    );
  }

  Container _buildKendaraanDropDown(List<Kendaraan> kendaraan) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
        ),
        value: _kendaraanSelected == 0 ? null : _kendaraanSelected,
        hint: Text(
          kendaraan.length > 0
              ? "Silakan pilih kendaraan"
              : "Tidak terdapat kendaraan",
          style: TextStyle(fontSize: 18),
        ),
        onChanged: (val) {
          setState(() {
            _kendaraanSelected = val;
          });
        },
        onSaved: (val) {
          setState(() {
            _kendaraanSelected = val;
          });
        },
        validator: (val) {
          if (val == null) {
            return "Harap pilih kendaraan";
          }
          return null;
        },
        items: kendaraan.map<DropdownMenuItem<int>>((value) {
          return DropdownMenuItem(
            value: value.id,
            child: Text(
              value.merk + ' - ' + value.brand,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }

  Container _buildOutletsDropdown(List<Outlet> outlets) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[300],
            ),
          ),
        ),
        value: _outletSelected == 0 ? null : _outletSelected,
        hint: Text(
          outlets.length > 0
              ? "Silakan Pilih Outlet"
              : "Tidak dapat menemukan outlet",
          style: TextStyle(fontSize: 18),
        ),
        validator: (val) {
          if (val == null) {
            return "Harap Pilih outlet";
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            _outletSelected = val;
          });
        },
        onSaved: (val) {
          setState(() {
            _outletSelected = val;
          });
        },
        items: outlets.map<DropdownMenuItem<int>>((value) {
          return DropdownMenuItem(
            value: value.id,
            child: Text(
              value.name,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
      ),
    );
  }

  GestureDetector _buildMyLocation(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(3),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                child: Text(
                  Provider.of<User>(context, listen: false).address,
                  maxLines: 1,
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Icon(
              Icons.location_on,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Maps(),
          ),
        );
      },
    );
  }
}
