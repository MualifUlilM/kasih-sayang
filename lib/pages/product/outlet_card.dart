import 'package:flutter/material.dart';

import './product_detail.dart';
import '../../providers/outlet.dart';

class OutletCard extends StatelessWidget {
  final Outlet _outlet;

  OutletCard(this._outlet);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(_outlet.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _outlet.address,
              maxLines: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${_outlet.distance} KM",
              maxLines: 1,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              outletId: _outlet.id,
              name: _outlet.name,
              address: _outlet.address,
            ),
          ),
        );
      },
    );
  }
}
