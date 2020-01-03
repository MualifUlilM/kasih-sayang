import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  int get itemCount {
    return _transactions.length;
  }

  Future<Map<String, dynamic>> fetchAndSetData(String token,
      {int page = 1}) async {
    Map<String, dynamic> _result;
    try {
      await Api().getTransactions(token, page).then((res) {
        if (res.data['api_status'] == 1) {
          setTransaction(res.data['data']);

          _result = {
            'success': true,
            'message': res.data['api_message'],
            'data': res.data['data'],
          };
        } else {
          _result = {
            'success': false,
            'message': res.data['api_message'],
          };
        }
      });
    } catch (e) {
      _result = {
        'success': false,
        'message': e.toString(),
      };
    }
    return _result;
  }

  setTransaction(List transactions) {
    final List<Transaction> tmp = [];
    for (var i = 0; i < transactions.length; i++) {
      final transaction = transactions[i];
      tmp.add(
        Transaction(
          id: transaction['id'],
          idCategory: transaction['id_mx_ms_category_service'],
          status: transaction['status'],
          date: DateFormat('yyyy-MM-dd HH:mm:ss')
              .parse(transaction['created_at']),
          outletName: transaction['mx_ms_outlets_name'],
          total: transaction['total'] == 0
              ? 0
              : transaction['total'] + transaction['ship'],
        ),
      );
    }

    this._transactions = tmp;

    notifyListeners();
  }
}

class Transaction {
  final int id;
  final int idCategory;
  final String status;
  final DateTime date;
  final String outletName;
  final int total;

  Transaction({
    this.id,
    this.idCategory,
    this.status,
    this.date,
    this.outletName,
    this.total,
  });
}
