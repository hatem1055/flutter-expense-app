import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function delTx;
  TransactionList(this.transactions,this.delTx);

  @override
  Widget build(BuildContext context) {
  final primaryColor = Theme.of(context).primaryColor;
  //converting the list of transactions into a list of widgets
  Widget createTransactionWidget(Transaction tx){
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5
        ),
        child: ListTile(
        leading:CircleAvatar(
          radius: 30,
          backgroundColor:primaryColor,
          child:Padding(
              padding:EdgeInsets.all(6),
              child: FittedBox(
              child: Text(
                '\$${tx.amount}',
                style:TextStyle(
                  fontWeight:FontWeight.bold,
                ),
              )
            ),
          ),
        ),
        title:Text(
          tx.title,
          style:Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(tx.date)
        ),
        trailing:IconButton(
          icon:Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: (){
            delTx(tx.id);
          },
        ),
      ),
    );
  }  
    final List<Widget> transactionWidgets = transactions.map(createTransactionWidget).toList();
    // adding transaction
    
    return Container(
      height: 400,
      child: transactions.isEmpty ? Column(
        children: [
          Text('no transactions added yet!',style:Theme.of(context).textTheme.headline6,),
          SizedBox(
            height:10,
          ),
          Container(
            height:100,
            child: Image.asset(
              'lib/assets/images/waiting.png',
              fit:BoxFit.cover,
            
            ),
          )
        ],
      )
      :ListView.builder(
        itemBuilder: (ctx, index) {
          return transactionWidgets[index];
        },
        itemCount:transactions.length,
      ),
    );
  }
}