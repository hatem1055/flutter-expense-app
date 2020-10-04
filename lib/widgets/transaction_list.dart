import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
  final primaryColor = Theme.of(context).primaryColor;
  //converting the list of transactions into a list of widgets
  Widget createTransactionWidget(Transaction tx){
    return Card(
      child:Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15,vertical:10),
            padding:EdgeInsets.all(10),
            decoration:BoxDecoration(
              border:Border.all(color:primaryColor, width:2 , style:BorderStyle.solid),
              color:primaryColor
            ),
            child: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style:TextStyle(
                fontWeight:FontWeight.bold,
                fontSize:20,
                color:Colors.white
                ),
              ),
          ),
          //Title & Date
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
            Text(
              tx.title,
              style:TextStyle(fontSize:16,fontWeight:FontWeight.bold),
            ),
            Text(
              DateFormat.yMMMd().format(tx.date),
              style:TextStyle(color:Colors.grey[600]),
            )
          ],)
      ],),
      );
    }  
    final List<Widget> transactionWidgets = transactions.map(createTransactionWidget).toList();
    // adding transaction
    
    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return transactionWidgets[index];
        },
        itemCount:transactions.length,
      ),
    );
  }
}