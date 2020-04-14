import 'package:flutter/material.dart';
import 'package:KasihSayang/models/transaksi.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailRiwayat extends StatefulWidget {
  int id;
  String token;
  DetailRiwayat(this.token, this.id);
  @override
  _DetailRiwayatState createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  Future _getDetailsTransaction(int id, String token) async {
    var res = await http.get(
        'http://maxiaga.com/backend/api/get_transaction_detail?id=$id&token=$token');
    var jsonRes;

    if (res.statusCode == 200) {
      print(jsonRes = json.decode(res.body));
      return jsonRes = json.decode(res.body);
    } else {
      throw Exception('Cannot Load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text(
            'Pesanan',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder(
          future: _getDetailsTransaction(widget.id, widget.token),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data['address']);
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3.5,
                    color: Theme.of(context).primaryColor,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(Icon(Icons.shopping_cart)),
                    //     fit: BoxFit.scaleDown,
                    //     alignment: Alignment.centerRight,
                    //     colorFilter: ColorFilter.mode(
                    //       Theme.of(context).primaryColor,
                    //       BlendMode.color,
                    //     ),
                    //   ),
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: snapshot.data['mx_ms_outlets_name'] == null
                              ? Text(
                                  'Pesananmu dari : Menuggu',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  maxLines: 1,
                                )
                              : Text(
                                  'Pesananmu dari : ${snapshot.data['mx_ms_outlets_name']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  maxLines: 1,
                                ),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: Text(
                              'Akan di antar ke : ${snapshot.data['address']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              maxLines: 1),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: Text('Status : ${snapshot.data['status']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              maxLines: 1),
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          child: Text('jenis : ${snapshot.data['jenis']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              maxLines: 1),
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.all(35),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                            color: Colors.black,
                          );
                        },
                        itemCount: snapshot.data['detail'].length == 0
                            ? 0
                            : snapshot.data['detail'].length + 2,
                        itemBuilder: (context, index) {
                          if (index < snapshot.data['detail'].length) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  snapshot.data['detail'][index]['qty']
                                          .toString() +
                                      'x',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              title: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                    snapshot.data['detail'][index]['name']),
                              ),
                              trailing: Text((snapshot.data['detail'][index]
                                      ['subtotal'])
                                  .toString()),
                            );
                          } else if (index == snapshot.data['detail'].length) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Total :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                  trailing:
                                      Text(snapshot.data['total'].toString()),
                                ),
                                ListTile(
                                  title: Text(
                                    'Biaya Pengantaran :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                  trailing:
                                      Text(snapshot.data['ship'].toString()),
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(bottom: 60),
                              child: ListTile(
                                title: Text(
                                  'TOTAL :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                                trailing: Text((snapshot.data['total'] +
                                        snapshot.data['ship'])
                                    .toString()),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  // Column(
                  //     children:
                  //         List.generate(snapshot.data['detail'].length, (i) {
                  //   return Container(
                  //     padding: EdgeInsets.all(20),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Text(
                  //               '${snapshot.data['detail'][i]['qty']} x',
                  //               style: TextStyle(fontSize: 18),
                  //             ),
                  //             Text(
                  //               '${snapshot.data['detail'][i]['name']}',
                  //               style: TextStyle(fontSize: 18),
                  //             ),

                  //             // Text(
                  //             //   '${snapshot.data['detail'][i]['price']}',
                  //             //   style: TextStyle(fontSize: 18),
                  //             // ),
                  //             Text(
                  //               '${snapshot.data['detail'][i]['subtotal']}',
                  //               style: TextStyle(fontSize: 18),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           // crossAxisAlignment: CrossAxisAlignment.start,
                  //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Container(
                  //                 margin: EdgeInsets.only(top: 20),
                  //                 // padding: EdgeInsets.symmetric(horizontal: 20),
                  //                 child: Divider(
                  //                   color: Colors.black,
                  //                   thickness: 1,
                  //                 )),
                  //             Container(
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: <Widget>[
                  //                   Text(
                  //                     'Total :',
                  //                     style: TextStyle(fontSize: 18),
                  //                   ),
                  //                   Text(
                  //                     '${snapshot.data['total']}',
                  //                     style: TextStyle(fontSize: 18),
                  //                   )
                  //                 ],
                  //               ),
                  //               padding: EdgeInsets.symmetric(vertical: 5),
                  //             ),
                  //             Container(
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: <Widget>[
                  //                   Text(
                  //                     'Biaya Pengiriman :',
                  //                     style: TextStyle(fontSize: 18),
                  //                   ),
                  //                   Text(
                  //                     '${snapshot.data['ship']}',
                  //                     style: TextStyle(fontSize: 18),
                  //                   )
                  //                 ],
                  //               ),
                  //               padding: EdgeInsets.symmetric(vertical: 5),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // })),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
