import 'package:flutter/material.dart';
import '../../providers/outlet.dart';

class OutletCard extends StatelessWidget {
  final Outlet _outlet;
  OutletCard(this._outlet);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: ListTile(
        leading: Container(
          child: Column(
            children: <Widget>[
              Text(_outlet.distance.toString()),
              Text('KM'),
            ],
          ),
        ),
        title: Text(
          _outlet.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Text(
              _outlet.address,
              maxLines: 2,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
