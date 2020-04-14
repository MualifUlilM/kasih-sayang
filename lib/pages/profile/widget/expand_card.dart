import 'package:flutter/material.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:KasihSayang/pages/profile/widget/list_kendaraan.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';
import '../screen/tambahkendaraan.dart';

class ExpandCard {
  ExpandableCard buildCard(BuildContext context){
    final userProvider = Provider.of<User>(context);
    return ExpandableCard(
      hasRoundedCorners: true,
      minHeight: 185,
      backgroundColor: Theme.of(context).primaryColor,
      maxHeight: MediaQuery.of(context).size.height,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Kendaraan",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text("Tambah",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      Icon(
                        Icons.add,
                        color: Colors.red,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TambahKendaraan(
                          token: userProvider.token,
                          // location: userProvider.location,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.70,
          child: Expanded(
            child: ListKendaraan())
        )
      ],
    );
  }
}