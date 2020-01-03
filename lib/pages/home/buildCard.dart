import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import '../../service/post/post.dart';
import '../../pages/order/bensin/bensin_page.dart';
import '../../pages/order/servis/service_page.dart';
import '../../pages/order/ban/ban_page.dart';
import '../../pages/order/oli/oli_page.dart';

class BuildCard extends StatelessWidget {
  Post post = Post();

  @override
  Widget build(BuildContext context) {
    // icon
    List<List<dynamic>> _iconName = [
      ["Service", Image.asset('lib/assets/images/servis.png')],
      ["Oli", Image.asset('lib/assets/images/oli.png')],
      ["Bensin", Image.asset('lib/assets/images/bensin.png')],
      ["Ban", Image.asset('lib/assets/images/ban.png')],
    ];

    // route
    List<Widget> pages = [ServicePage(), OliPage(), BensinPage(), BanPage()];

    return Container(
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 20,
          MediaQuery.of(context).size.height / 2.5,
          MediaQuery.of(context).size.width / 20,
          0,
        ),
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2.0), blurRadius: 6)
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: List.generate(4, (index) {
              return Container(
                // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: _iconName[index][1],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pages[index]),
                          );
                        },
                      ),
                      Container(child: Text(_iconName[index][0])),
                    ]),
              );
            }),
          ),
        ));
  }
}
