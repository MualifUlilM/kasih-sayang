import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/material.dart';
import 'package:KasihSayang/pages/profile/widget/expand_card.dart';
import 'package:KasihSayang/pages/profile/widget/page_builder.dart';
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
      body: PageBuilder()
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
