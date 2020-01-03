import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';
import '../screen/edithapuskendaraan.dart';

class ListKendaraan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    return ListView(
      children: List.generate(userProvider.kendaraan.length, (index) {
            return FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>EditRemoveKendaraan(
                    kendaraan: userProvider.kendaraan[index],
                  ),
                ));
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: userProvider.kendaraan[index].typeId == 1
                        ? Image.asset(
                            'lib/assets/images/motorputih.png',
                            scale: 3,
                          )
                        : Image.asset(
                            'lib/assets/images/mobilputih.png',
                            scale: 3,
                            alignment: Alignment.centerRight,
                          ),
                    title: Text(
                      '${userProvider.kendaraan[index].merk} - ${userProvider.kendaraan[index].brand}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
