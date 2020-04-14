import 'package:flutter/material.dart';

class AppBarBikin extends StatelessWidget {
  static const List<Color> colors = [
    Color(0xFFF36DB6),
    Color(0xFF52CFE1),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: MediaQuery.of(context).size.height * 0.102,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors,
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(3.0, 0.0),
              stops: [0, 0.3],
              tileMode: TileMode.clamp)),
      child: Image.asset(
        'lib/assets/images/tanpabg.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
