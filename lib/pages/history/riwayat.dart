import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:maxiaga/models/transaksi.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../providers/user.dart';
import 'package:maxiaga/pages/history/detailriwayat.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  // List<String> user = [
  //   "User 1",
  //   "User 2",
  //   "User 3",
  //   "User 4",
  //   "User 1",
  //   "User 2",
  //   "User 3",
  //   "User 4",
  //   "User 1",
  //   "User 2",
  //   "User 3",
  //   "User 4",
  // ];
  // List<String> tipe = [
  //   "Motor",
  //   "Mobil",
  //   "Mobil",
  //   "Motor",
  //   "Motor",
  //   "Mobil",
  //   "Mobil",
  //   "Motor",
  //   "Motor",
  //   "Mobil",
  //   "Mobil",
  //   "Motor",
  // ];
  // List<String> harga = [
  //   "20000",
  //   "250000",
  //   "10000",
  //   "7000",
  //   "20000",
  //   "250000",
  //   "10000",
  //   "7000",
  //   "20000",
  //   "250000",
  //   "10000",
  //   "7000",
  // ];
  // List<String> tanggal = [
  //   "10 sep",
  //   "22 sep",
  //   "1 okt",
  //   "6 okt",
  //   "10 sep",
  //   "22 sep",
  //   "1 okt",
  //   "6 okt",
  //   "10 sep",
  //   "22 sep",
  //   "1 okt",
  //   "6 okt",
  // ];
  // List<Icon> icon = [];

  // Color warna(int index) {
  //   if (tipe[index] == 'motor' || tipe[index] == 'Motor') {
  //     return Colors.red;
  //   } else {
  //     return Colors.blue[600];
  //   }
  // }

  // Image setKendaraan(int index) {
  //   if (tipe[index] == 'motor' || tipe[index] == 'Motor') {
  //     return Image.asset(
  //       'lib/assets/images/motor.png',
  //     );
  //   } else {
  //     return Image.asset(
  //       'lib/assets/images/mobil.png',
  //     );
  //   }
  // }

  _getRiwayat(String token) async {
    var res = await http
        .get('http://maxiaga.com/backend/api/get_transaction?token=$token');
    var jsonData = json.decode(res.body);

    if (res.statusCode == 200) {
      print(jsonData);
      // print(jsonData['data'][0]);
      // print(jsonData['data'][1]);
      // print(jsonData['data'][2]);
      print('ini setelah data');
      return jsonData;
    } else {
      throw Exception('cannot load data');
    }
  }

  _buildTransaction(int id) {
    if (id == 1) {
      return Image.asset(
        'lib/assets/images/servis.png',
        scale: 4,
      );
    } else if (id == 2) {
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: Image.asset(
          'lib/assets/images/oli.png',
          scale: 3,
        ),
      );
    } else if (id == 3) {
      return Image.asset(
        'lib/assets/images/bensin.png',
        scale: 3,
      );
    } else if (id == 4) {
      return Image.asset(
        'lib/assets/images/ban.png',
        scale: 3,
      );
    } else {
      return Icon(
        Icons.shopping_cart,
        color: Color.fromRGBO(33, 33, 109, 1.0),
        size: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/maxiaga_putih.png',
          scale: 20,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Riwayat",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: FutureBuilder(
              future: _getRiwayat(userData.token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (snapshot.data['data'].length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, i) => InkWell(
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 5.0,
                          child: ListTile(
                            leading: _buildTransaction(snapshot.data['data'][i]
                                ['id_mx_ms_category_service']),
                            title: Text(
                              snapshot.data['data'][i]['mx_ms_outlets_name'] !=
                                      null
                                  ? snapshot.data['data'][i]
                                          ['mx_ms_outlets_name']
                                      .toString()
                                  : "Menunggu",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(snapshot.data['data'][i]['status']),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Rp ' +
                                      (snapshot.data['data'][i]['total'] == 0
                                              ? 0
                                              : (snapshot.data['data'][i]
                                                          ['total'] +
                                                      snapshot.data['data'][i]
                                                          ['ship'])
                                                  .toString())
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(33, 33, 109, 1.0),
                                  ),
                                ),
                                Text(
                                  DateFormat.MMMd()
                                      .format(
                                        DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                                            snapshot.data['data'][i]
                                                ['created_at']),
                                      )
                                      .toString(),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRiwayat(
                                userData.token,
                                snapshot.data['data'][i]['id'],
                              ),
                            ),
                          );
                        },
                      ),
                    );

                    // SingleChildScrollView(
                    //   child: Column(
                    //     children:
                    //         List.generate(snapshot.data['data'].length, (i) {
                    //       return
                    //     }),
                    //   ),
                    // );
                  } else {
                    return Center(
                      child: Text(
                        'Maaf Anda Belum Memiliki Transaksi Apapun',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
