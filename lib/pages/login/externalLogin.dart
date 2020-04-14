import 'package:flutter/material.dart';

class ExternalLogin extends StatelessWidget {
  List<String> imgPath = [
    'lib/assets/images/search.png',
    'lib/assets/images/facebook-logo.png',
    'lib/assets/images/twitter.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(imgPath.length, (i) {
          return buildButtonLogo(imgPath[i], context);
        }),
      ),
    );
  }

  Widget buildButtonLogo(String path, BuildContext context) {
    return FlatButton(
      highlightColor: Colors.transparent,
      onPressed: (){},
          child: Container(
        height: MediaQuery.of(context).size.height * 0.075,
        width: MediaQuery.of(context).size.width * 0.15,
        child: Center(
            child: Image.asset(
          path,
          scale: 12,
        )),
      ),
    );
  }
}
