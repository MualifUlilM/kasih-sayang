import 'package:flutter/material.dart';

class ExternalLogin extends StatelessWidget {
  List<String> imgPath = [
    'lib/assets/images/googlered.png',
    'lib/assets/images/fbred.png',
    'lib/assets/images/tweetred.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(imgPath.length, (i){
          return buildButtonLogo(imgPath[i], context);
        }),
      ),
    );
  }

  Widget buildButtonLogo(String path, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.1,
      child: Center(
          child: Image.asset(
        path,
      )
          ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
