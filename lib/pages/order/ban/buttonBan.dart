import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maxiaga/api.dart';
import 'package:maxiaga/assets/maxcolor.dart';
import 'package:maxiaga/service/post/post.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../my_home_page.dart';
import '../../../providers/user.dart';

class ButtonBan {
  Post post = Post();
  RaisedButton buildButtonBan(
    BuildContext context,
    int order,
    double lng,
    double lat,
    String token,
    String text,
  ) {
    final userProvider = Provider.of<User>(context);
    ProgressDialog pr =
        ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      progressWidget: CircularProgressIndicator(),
      borderRadius: 10,
      message: "Tunggu Sebentar...",
    );
    return RaisedButton(
      color: MaxColor.merah,
      child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Center(
              child: Text(
            '$text',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ))),
      onPressed: () {
        pr.show();
        // post.postOrderBan(order, token, lng, lat).then((value) {
        //   pr.hide();
        //   print(value);
          
        // });
        Api().reqApi(
          method: 'POST',
          url: 'post_order',
          data: {
            'token': userProvider.token,
                "id_mx_ms_category_service": '3',
                'id_mx_ms_outlets': '1',
                'address': userProvider.address,
                'detail_address': 'Sint adipisicing esse ea minim excepteur.',
                'lng': userProvider.lng.toString(),
                'lat': userProvider.lat.toString(),
                "id_mx_ms_category_service": 3,
          }
        ).then((value){
          print(value);
          if (value.data['api_status'] != 1) {
            pr.hide();
            showDialog(
              barrierDismissible: false,
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Terjadi kesalahan'),
            content: Text(
              value.data['api_message'].toString(),
              // ''
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
          } else {
                      Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage(2),
              ),
              (Route<dynamic> route) => false);
          }
        });
      },
    );
  }
}
