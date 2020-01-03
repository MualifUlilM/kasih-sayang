import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:maxiaga/pages/profile/widget/expand_card.dart';
import 'package:maxiaga/pages/profile/widget/page_builder.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';
import '../splashScreen/splashlogout.dart';
import 'screen/editprofile.dart';

class Profile extends StatefulWidget {
  static const routingName = 'Profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    print('Executed');
    super.initState();
  }

  Widget _buildListKendaraan() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    print('langsung dari User()');
    User().getKendaraan();
    print('darti userProvider');
    userProvider.getKendaraan();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>EditProfile(
                    name: userProvider.name,
                    email: userProvider.email,
                    phone: userProvider.phone,
                    kota: userProvider.kota,
                    gender: userProvider.gender,
                  ))
                );
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
              onPressed: () {return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
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
                            userProvider.logout().then((value){
                                Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SplashLogout(userProvider.token)),
                                (Route<dynamic> route) => false);
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
      ),
      body: ExpandableCardPage(
          expandableCard: ExpandCard().buildCard(context), page: PageBuilder()),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
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
        },
      ),
    );
  }

}
