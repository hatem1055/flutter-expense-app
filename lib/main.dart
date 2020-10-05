
import 'package:flutter/material.dart';

import 'widgets/transaction_list.dart';
import 'widgets/add_tx_form.dart';
import 'models/transaction.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme:ThemeData(
        primarySwatch:Colors.purple,
        fontFamily:'Quicksand',
        textTheme:ThemeData.light().textTheme.copyWith(
          headline6:TextStyle(
              fontFamily:'OpenSans',
              fontSize:18,
              fontWeight:FontWeight.bold
          )
        ),
        appBarTheme:AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
            headline6:TextStyle(
              fontFamily:'OpenSans',
              fontSize:20,
              fontWeight:FontWeight.bold
            )
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(title:'Math Membrship',id:'t1',amount:560,date:DateTime.now()),
    // Transaction(title:'English Membrship',id:'t2',amount:400,date:DateTime.now())
  ];

  void _addTx(String title,double amount){
  final newTx = Transaction(title:title,amount:amount,date:DateTime.now(),id:DateTime.now().toString());
    setState(() {
      transactions.add(newTx);
    });
  }

  void startAddNewTransaction(ctx){
    showModalBottomSheet(context:ctx, builder:(_){
      return  AddTxForm(_addTx);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
    appBar: AppBar(
        title: Text('Personal Expenses'),
        backgroundColor:primaryColor,
        actions: [
          IconButton(
            icon:Icon(Icons.add),
            onPressed:(){startAddNewTransaction(context);},
          )
        ],
      ),
      //floating action button
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Container(
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(500),
          color:Theme.of(context).primaryColor
        ),
        child: IconButton(
          icon:Icon(Icons.add),
          color:Colors.white,
          onPressed: (){startAddNewTransaction(context);},
        ),
      ),
      //Body
      body:SingleChildScrollView(
        child:Column(children:[
          Container(
          width: double.infinity,
          child: Card(
              color:primaryColor,
              child: Text('CHART!!'),
          ),
        ),
        TransactionList(transactions)
      ],
      )
      ),
    );
  }
}
