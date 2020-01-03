import 'package:flutter/material.dart';

import './profile_button.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width / 20,
        MediaQuery.of(context).size.height / 10,
        MediaQuery.of(context).size.width / 20,
        MediaQuery.of(context).size.height / 6,
      ),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(color: Color(0xFFD22222)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 50,
            child: Image.asset(
              'lib/assets/images/maxiaga_putih.png',
            ),
          ),
          ProfileButton(),
        ],
      ),
    );
  }
}
