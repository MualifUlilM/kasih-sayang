import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';
import '../../profile/screen/editprofile.dart';
import '../../splashScreen/splashlogout.dart';

class PageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFFF36DB6),
                      Color(0xFF52CFE1),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(3.0, 0.0),
                    stops: [0, 0.3],
                    tileMode: TileMode.clamp)),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            child: RaisedButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              color: Colors.transparent,
                              elevation: 0,
                              child: Center(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                              onPressed: () {
                                print(userProvider.photo);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                              name: userProvider.name,
                                              email: userProvider.email,
                                              phone: userProvider.phone,
                                              kota: userProvider.kota,
                                              gender: userProvider.gender,
                                            )));
                              },
                            ),
                          ),
                          Container(
                            width: 60,
                            child: RaisedButton(
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: Center(
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Logout?'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Anda Yakin Ingin Keluar?'),
                                            // Text('You\’re like me. I’m never satisfied.'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ya'),
                                          onPressed: () async {
                                            userProvider.logout().then((value) {
                                              print(value);
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SplashLogout(
                                                                  userProvider
                                                                      .token)),
                                                      (Route<dynamic> route) =>
                                                          false);
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
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  // backgroundImage: AssetImage('lib/assets/images/avatar.png'),
                  backgroundImage: NetworkImage(userProvider.photo),
                  radius: 50,
                  backgroundColor: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    "${userProvider.name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    "${userProvider.email}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Kota",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "${userProvider.kota}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Telepon",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: userProvider.phone != null
                        ? Text(
                            "${userProvider.phone}",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "-",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: userProvider.phone != null
                        ? Text(
                            "Jomblo",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "-",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
