import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../assets/maxcolor.dart';
import '../../pages/login/forgetAndCreate.dart';
import '../../pages/login/loginForm.dart';
import '../../pages/login/externalLogin.dart';
import '../../pages/my_home_page.dart';
import '../../providers/user.dart';
import '../../providers/outlets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog pr;
  bool isLogin = false;
  bool _isInit = true;

  bool loginGagal = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final userProvider = Provider.of<User>(context, listen: false);
      final outletsProvider = Provider.of<Outlets>(context, listen: false);
      userProvider.checkLogin().then((res) {
        pr.hide();
        if (res['success']) {
          outletsProvider.setOutlets(res['data']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage(0),
              ),
              (Route<dynamic> route) => false);
        }
        setState(() {
          _isInit = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(
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

    Future.delayed(Duration(seconds: 1)).then((_) {
      if (_isInit) {
        pr.show();
      }
    });

    return Scaffold(
        appBar: null,
        key: scaffoldKey,
        backgroundColor: MaxColor.merah,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // gambar maxiaga
              Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                    // color: Colors.red
                    ),
                child: Center(
                  child: Container(
                    height: 120,
                    width: 230,
                    child: Image.asset('lib/assets/images/maxiaga_putih.png'),
                  ),
                ),
              ),
              // form
              Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Selamat datang",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "LOGIN untuk Lanjut",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    LoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
