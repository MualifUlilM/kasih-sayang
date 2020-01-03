import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../assets/maxcolor.dart';

class LoginButton extends StatelessWidget {
  final Position location;
  final String email;
  final String password;
  final formKey;

  LoginButton(
    this.formKey,
    this.location,
    this.email,
    this.password,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        height: 60,
        decoration: BoxDecoration(
            color: MaxColor.merah, borderRadius: BorderRadius.circular(5)),
        child: FlatButton(
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              // signIn(email, password, location);
            }
          },
        ));
  }
}
