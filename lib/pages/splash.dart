import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import '../assets/maxcolor.dart';
import '../pages/login/login.dart';
import '../providers/articles.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Provider.of<Articles>(context, listen: false).fetchAndSet(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: LoginPage(),
      image: Image.asset(
        'lib/assets/images/maxiaga_putih.png',
      ),
      photoSize: 120,
      backgroundColor: MaxColor.merah,
      styleTextUnderTheLoader: new TextStyle(),
    );
  }
}
