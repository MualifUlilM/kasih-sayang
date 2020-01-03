import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';
import '../screen/editprofile.dart';
import '../../splashScreen/splashlogout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../pages/login/login.dart';
import '../../../providers/user.dart';
import '../../profile/profile.dart';

class AppbarButton extends StatelessWidget {
  Future showDialog;
  Future navigator;
  AppbarButton({this.showDialog, this.navigator});
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return Row(
      children: <Widget>[
        
      ],
    );
  }
}
