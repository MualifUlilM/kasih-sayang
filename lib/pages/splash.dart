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
        'lib/assets/images/tanpabg.png',
      ),
      photoSize: 120,
      // backgroundColor: MaxColor.merah,
      gradientBackground: LinearGradient(
                colors: [
                  Color(0xFFF36DB6),
                  Color(0xFF52CFE1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(3.0, 0.0),
                stops: [0,0.3],
                tileMode: TileMode.clamp
              ),
      styleTextUnderTheLoader: new TextStyle(),
    );
  }
}
