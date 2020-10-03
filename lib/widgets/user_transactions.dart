import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './add_tx_form.dart';
import './transaction_list.dart';

class UserTranactions extends StatefulWidget {
  @override
  _UserTranactionsState createState() => _UserTranactionsState();
}

class _UserTranactionsState extends State<UserTranactions> {

  final List<Transaction> transactions = [
    Transaction(title:'Math Membrship',id:'t1',amount:560,date:DateTime.now()),
    Transaction(title:'English Membrship',id:'t2',amount:400,date:DateTime.now())
  ];

  void _addTx(String title,double amount){
    final newTx = Transaction(title:title,amount:amount,date:DateTime.now(),id:DateTime.now().toString());
    setState(() {
      transactions.add(newTx);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children:[
      AddTxForm(_addTx),
      TransactionList(transactions)
    ]);
  }
}