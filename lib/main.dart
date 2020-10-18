//dart
import 'dart:io';

//packeges
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//widgets
import 'widgets/transaction_list.dart';
import 'widgets/add_tx_form.dart';
import 'widgets/chart.dart';
//models
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  //Theming
  Widget build(BuildContext context) {
    //Theming
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    button: TextStyle(
                      color: Colors.white,
                    ),
                  ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //dynamic values
  List<Transaction> transactions = [];
  bool swichValue = true;



  //change swich value
  void toggleSwich(val) {
    setState(() {
      swichValue = val;
    });
  }

  //adding transaction method
  void _addTx(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      transactions.add(newTx);
    });
  }

  //trigring add transaction modal
  void startAddNewTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTxForm(_addTx);
        },
        isScrollControlled: true);
  }

  //deleting transaction
  void deleteTx(id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  //get transactions for the last week only
  List<Transaction> get transactionsLastWeek {
    final lastWeek = DateTime.now().subtract(Duration(days: 7));
    return transactions.where((tx) {
      return tx.date.isAfter(lastWeek);
    }).toList();
  }

  //Builder Method
  List<Widget> buildsLandscapeContent(primaryColor, txWidget, chartWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            value: swichValue,
            onChanged: toggleSwich,
            activeColor: primaryColor,
          ),
        ],
      ),
      swichValue ? chartWidget(.7) : txWidget
    ];
  }

  List<Widget> buildsPortraitContent(chartWidget, txWidget) {
    return [chartWidget(.3), txWidget];
  }

  @override
  Widget build(BuildContext context) {
    //static info
    final primaryColor = Theme.of(context).primaryColor;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      backgroundColor: primaryColor,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            startAddNewTransaction(context);
          },
        )
      ],
    );
    final pageHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    //widgets
    final txWidget = Container(
      height: pageHeight * .7,
      child: TransactionList(transactions, deleteTx),
    );

    Widget chartWidget(heghitPerc) {
      return Container(
        height: pageHeight * heghitPerc,
        child: Chart(transactionsLastWeek),
        alignment: Alignment.center,
      );
    }

    return Scaffold(
      //app bar
      appBar: appBar,
      //floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isAndroid
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: Theme.of(context).primaryColor),
              child: IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  startAddNewTransaction(context);
                },
              ),
            )
          : Container(),

      //Body
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            if (isLandscape)
              ...buildsLandscapeContent(primaryColor, txWidget, chartWidget),
            if (!isLandscape) ...buildsPortraitContent(chartWidget, txWidget)
          ],
        )),
      ),
    );
  }
}
