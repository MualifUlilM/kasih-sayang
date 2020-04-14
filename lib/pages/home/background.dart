import 'package:flutter/material.dart';

import './profile_button.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(
      //   MediaQuery.of(context).size.width / 20,
      //   MediaQuery.of(context).size.height / 10,
      //   MediaQuery.of(context).size.width / 20,
      //   MediaQuery.of(context).size.height / 6,
      // ),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        gradient:LinearGradient(
                colors: [
                  Color(0xFFF36DB6),
                  Color(0xFF52CFE1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(3.0, 0.0),
                stops: [0,0.3],
                tileMode: TileMode.clamp
              )
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(

              // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: MediaQuery.of(context).size.height * 0.37,
              child: Image.asset(
                'lib/assets/images/tanpabg.png',fit: BoxFit.fill,
              ),
            ),
          ),
          ProfileButton(),
        ],
      ),
    );
  }
}
