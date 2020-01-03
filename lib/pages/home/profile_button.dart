import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/login/login.dart';
import '../../providers/user.dart';
import '../profile/profile.dart';

class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<User>(context);
    return FlatButton(
      onPressed: () {
        print(userProvider.email);
        // userProvider.logout();
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => LoginPage(),
            builder: (context) => Profile(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Hello...",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              userProvider.name == null
                  ? Text('')
                  : Text(
                      "${userProvider.name}",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
            ],
          ),
          CircleAvatar(
            backgroundImage: userProvider.photo == null
                ? AssetImage('lib/assets/images/avatar.png')
                : NetworkImage(userProvider.photo),
            radius: MediaQuery.of(context).size.width / 10,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          )
        ],
      ),
    );
  }
}
