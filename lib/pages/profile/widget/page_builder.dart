import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';

class PageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  // backgroundImage: AssetImage('lib/assets/images/avatar.png'),
                  backgroundImage: NetworkImage(userProvider.photo),
                  radius: 50,
                  backgroundColor: Colors.transparent,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    "${userProvider.name}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    "${userProvider.email}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Kota",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "${userProvider.kota}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Telepon",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: userProvider.phone != null
                        ? Text(
                            "${userProvider.phone}",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "-",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
