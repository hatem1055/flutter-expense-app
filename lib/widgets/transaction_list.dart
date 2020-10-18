import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;
  TransactionList(this.transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    //converting the list of transactions into a list of widgets
    Widget createTransactionWidget(Transaction tx) {
      
      return TransactionItem(key:ValueKey(tx.id),delTx : delTx,tx : tx);
    }

    final List<Widget> transactionWidgets =
        transactions.map(createTransactionWidget).toList();
    // adding transaction

    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  Text(
                    'no transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constrains.maxHeight * .6,
                    child: Image.asset(
                      'lib/assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView(
              children:transactionWidgets
          ),
            
          
    );
  }
}

