import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:KasihSayang/pages/lupa_password/lupa_password_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import '../my_home_page.dart';
import 'package:KasihSayang/pages/splashScreen/splashlogin.dart';
import 'package:KasihSayang/providers/user.dart';
import '../../assets/maxcolor.dart';
import '../signup/register.dart';
import 'externalLogin.dart';

class LoginForm extends StatefulWidget {
  Position location;

  LoginForm({this.location});
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Color obsecureColor = Colors.black;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool loginGagal = false;

  bool _obsecure = true;
  void _setObsecure() {
    setState(() {
      _obsecure = !_obsecure;
      if (obsecureColor == MaxColor.merah) {
        obsecureColor = Colors.black;
      } else {
        obsecureColor = MaxColor.merah;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<User>(context);
    ProgressDialog pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

    pr.style(
      message: 'Tunggu Sebentar . . .',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Container(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              // textInputAction: TextInputAction.next,
              onSaved: (val) {
                _username = val;
              },
              validator: (val) {
                return val.isEmpty ? "Email kosong" : null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: passwordController,
              onSaved: (val) {
                _password = val;
              },
              obscureText: _obsecure,
              validator: (val) {
                return val.length < 1 ? "Password kosong" : null;
              },
              decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: FlatButton(
                    child: Icon(
                      Icons.remove_red_eye,
                      color: obsecureColor,
                    ),
                    onPressed: _setObsecure,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.028),
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(5)),
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
                    // loadingDialog(context, 'Please Wait . . .');
                    pr.show();
                    userProvider
                        .signIn(
                      emailController.text,
                      passwordController.text,
                    )
                        .then(
                      (resp) {
                        // Navigator.of(context, rootNavigator: true).pop();
                        pr.hide();
                        if (resp['success']) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    // SplashLogin(userProvider.token),
                                    MyHomePage(0),
                              ),
                              (Route<dynamic> route) => false);
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Terjadi Kesalahan'),
                              content: Text(
                                resp['message'],
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text("Lupa Password?"),
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPasswordPage.routingName);
                    },
                  ),
                  FlatButton(
                    child: Text("Buat Akun"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  ),
                ],
              ),
            ),
            // Text('Atau Login Dengan'),
            // ExternalLogin(),
          ],
        ),
      ),
    );
  }

  Future loadingDialog(BuildContext context, String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(text)
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> _mapKendaraanData(List<dynamic> kendaraan) {
    try {
      var res = kendaraan.map((v) => json.encode(v)).toList();
      return res;
    } catch (err) {
      return [];
    }
  }

  signIn(String email, pass, Position location) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Tunggu Sebentar...')
                    ],
                  )));
        });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass,
    };
    var jsonRes = null;
    var res = await http.post("http://maxiaga.com/backend/api/post_login",
        body: data);
    Navigator.of(context, rootNavigator: true).pop();
    if (res.statusCode == 200) {
      jsonRes = json.decode(res.body);
      if (jsonRes != null && jsonRes['api_status'] == 1) {
        setState(() {
          _isLoading = false;
        });
        preferences.setString("token", jsonRes['token']);
        preferences.setString("name", jsonRes['name']);
        preferences.setString("photo", jsonRes['photo']);
        preferences.setString("email", jsonRes['email']);
        preferences.setString("phone", jsonRes['phone']);
        preferences.setString("gender", jsonRes['gender']);
        preferences.setString("kota", jsonRes['kota']);
        preferences.setString("phone", jsonRes['phone']);

        preferences.setStringList(
            'kendaraan', _mapKendaraanData(jsonRes['kendaraan']));
        print(preferences.getStringList('kendaraan'));
        print(preferences.get("token"));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    SplashLogin(jsonRes['token'])),
            (Route<dynamic> route) => false);
      } else {
        loginGagal = true;
        print(loginGagal);
        print(jsonRes['api_message']);
        setState(() {});
      }
    } else {
      throw Exception('Cannot Login');
    }
  }
}
