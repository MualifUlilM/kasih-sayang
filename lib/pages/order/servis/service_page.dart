import 'dart:convert';
import 'dart:io';

import 'package:KasihSayang/appBar.dart';
import 'package:KasihSayang/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:KasihSayang/models/spbu.dart';
import 'package:KasihSayang/pages/Maps.dart';
import 'package:KasihSayang/service/post/post.dart';

import '../../my_home_page.dart';
import '../../../providers/user.dart';
import '../../../providers/outlets.dart';
import '../../../providers/outlet.dart';
import '../../../models/orders.dart';
import '../../transactions/transactions_page.dart';

import 'package:KasihSayang/models/drink_model.dart';

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
  int _qty = 1;

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

  void incrementQty(){
    setState(() {
      _qty++;
    });
  }

  void decrementQty(){
    setState(() {
      _qty--;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final drinkProvider = Provider.of<Cart>(context);
   return Scaffold(
    //  appBar: AppBar(
    //    title: Text("Minuman"),
    //  ),
     body: Column(
       children: <Widget>[
         AppBarBikin(),
         Expanded(
                child: ListView.separated(itemBuilder: (context, i){
             return FlatButton(
               onPressed: (){
                 showDialog(context: context, 
                 barrierDismissible: false,
                 child: MyDialog(drink: Drinker.drinks[i],));
               },
                      child: Container(
                 margin: EdgeInsets.all(5),
                 height: MediaQuery.of(context).size.height * 0.09,
                 decoration: BoxDecoration(
                  //  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10)
                 ),
                 child: Center(
                   child: ListTile(
                     leading: Container(child: Image.network("${Drinker.drinks[i].imgUrl}",fit: BoxFit.cover,), width: MediaQuery.of(context).size.width * 0.1,),
                     title: Text("${Drinker.drinks[i].name}"),
                     subtitle: Text("${Drinker.drinks[i].desc}"),
                     trailing: Text("Rp ${Drinker.drinks[i].harga}"),
                   ),
                 )
               ),
             );
           },
            separatorBuilder: (context, i)=>Divider(), itemCount: Drinker.drinks.length),
         ),
       ],
     )
   );
  }
}

class MyDialog extends StatefulWidget {
  Drink drink;
  MyDialog({this.drink});
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    return AlertDialog(
      
      title: Text(widget.drink.name),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Jumlah : $_counter'),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _counter > 1 ? IconButton(icon: Icon(Icons.remove), onPressed: (){
                  setState(() {
                    _counter--;
                  });
                }) : IconButton(icon: Icon(Icons.remove), onPressed: null),
                IconButton(icon: Icon(Icons.add), onPressed: (){
                  setState(() {
                    _counter++;
                  });
                }),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Ga Jadi')),
        FlatButton(onPressed: (){
          cartProvider.addItem(1, 'sampangan', widget.drink.id, widget.drink.harga, widget.drink.name, widget.drink.imgUrl, _counter);
          Navigator.pop(context);
        }, child: Text('Tambah Minuman Lain')),
        FlatButton(onPressed: (){
           cartProvider.addItem(1, 'sampangan', widget.drink.id, widget.drink.harga, widget.drink.name, widget.drink.imgUrl, _counter);
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>MyHomePage(2)),(Route route)=>false);
        }, child: Text('Udah')),
      ],
    );
  }
}