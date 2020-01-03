import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/transactions.dart';
import '../../providers/user.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(
    this._transactions,
  );

  Future<void> _refreshTransactions(context) async {
    final userData = Provider.of<User>(context, listen: false);
    await Provider.of<Transactions>(context, listen: false)
        .fetchAndSetData(userData.token);
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context);
    return RefreshIndicator(
      onRefresh: () => _refreshTransactions(context),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: _transactions.length > 0 ? _transactions.length : 1,
        itemBuilder: (context, i) => _transactions.length > 0
            ? TransactionItem(_transactions[i], userData.token)
            : Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Belum terdapat transaksi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Seret Kebawah untuk menyegarkan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
