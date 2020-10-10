import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/transaction.dart';
import 'chart_bar.dart';
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

      return {'day':dayFormated[0],'amount':totalAmount};
    });
  }

  double get totalMountsThisWeek{
    return groupedTransactionsValue.fold(0, (previousValue, element){
      return previousValue + element['amount'];
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin:EdgeInsets.all(20),
      child:Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children:[...groupedTransactionsValue.map((data){
            final perc = totalMountsThisWeek != 0 ? data['amount'] / totalMountsThisWeek : 0.0; 
            return Flexible(
              fit: FlexFit.tight,
              child:Container(
                margin:EdgeInsets.all(2.5),
                child: ChartBar(data['day'],data['amount'],perc)
              ) ,
            );
          }).toList()],
        ),
      ),
    );
  }
}