import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/transaction.dart';
class Chart extends StatelessWidget {

  final List<Transaction> transactions;
  Chart(this.transactions);

  //Formating and grouping transaction getter
  List<Map> get groupedTransactionsValue{
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days:index),);
      final dayFormated = DateFormat.E().format(day);
      double totalAmount = 0;

      for(final tx in transactions){
        // date validations
        final dayValidation = tx.date.day == day.day; 
        final monthValidation = tx.date.month == day.month; 
        final yearValidation = tx.date.year == day.year; 

        if (dayValidation && monthValidation && yearValidation){
          totalAmount += tx.amount; 
        }

      }

      return {'day':dayFormated,'amount':totalAmount};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin:EdgeInsets.all(20),
      child:Row(),
    );
  }
}