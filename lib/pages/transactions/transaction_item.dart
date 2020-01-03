import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/transactions.dart';
import '../transaction_detail/transaction_detail.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final String token;

  TransactionItem(this.transaction, this.token);

  _iconList(int id) {
    if (id == 1) {
      return Image.asset(
        'lib/assets/images/servis.png',
        scale: 4,
      );
    } else if (id == 2) {
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: Image.asset(
          'lib/assets/images/oli.png',
          scale: 3,
        ),
      );
    } else if (id == 3) {
      return Image.asset(
        'lib/assets/images/bensin.png',
        scale: 3,
      );
    } else if (id == 4) {
      return Image.asset(
        'lib/assets/images/ban.png',
        scale: 3,
      );
    } else {
      return Icon(
        Icons.shopping_cart,
        color: Color.fromRGBO(33, 33, 109, 1.0),
        size: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 5.0,
        child: ListTile(
          leading: _iconList(transaction.idCategory),
          title: Text(
            transaction.outletName != null
                ? transaction.outletName
                : "Menunggu",
            maxLines: 1,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(transaction.status),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Rp ' +
                    (transaction.total == 0 ? 0 : transaction.total).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(33, 33, 109, 1.0),
                ),
              ),
              Text(
                DateFormat.MMMd()
                    .format(
                      DateFormat('yyyy-MM-dd HH:mm:ss').parse(
                        transaction.date.toString(),
                      ),
                    )
                    .toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              token,
              transaction.id,
            ),
          ),
        );
      },
    );
  }
}
