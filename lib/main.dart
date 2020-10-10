//packeges
import 'package:flutter/material.dart';

//widgets
import 'widgets/transaction_list.dart';
import 'widgets/add_tx_form.dart';
import 'widgets/chart.dart';
//models
import 'models/transaction.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //Theming
  Widget build(BuildContext context) {
    //Theming 
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
          ),
        ),
        appBarTheme:AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
            headline6:TextStyle(
              fontFamily:'OpenSans',
              fontSize:20,
              fontWeight:FontWeight.bold
            ),
            button:TextStyle(
              color:Colors.white,
            ) ,
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
  List<Transaction> transactions = [];


  //adding transaction method
  void _addTx(String title,double amount,DateTime date){
  final newTx = Transaction(title:title,amount:amount,date:date,id:DateTime.now().toString());
    setState(() {
      transactions.add(newTx);
    });
  }

  //trigring add transaction modal
  void startAddNewTransaction(ctx){
    showModalBottomSheet(context:ctx, builder:(_){
      return  AddTxForm(_addTx);
    }
    );
  }

  //deleting transaction 
  void deleteTx(id){
    print(transactions[0].id);
    setState((){
      transactions.removeWhere((element)=>element.id == id);
    });
  }

  //get transactions for the last week only
  List<Transaction> get transactionsLastWeek{
      final lastWeek = DateTime.now().subtract(Duration(days:7));
      return transactions.where((tx){
        return tx.date.isAfter(lastWeek);
      }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(

    //app bar
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
        Chart(transactionsLastWeek),
        TransactionList(transactions,deleteTx)
      ],
      )
      ),
    );
  }
}
