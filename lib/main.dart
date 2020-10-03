
import 'package:flutter/material.dart';

import 'widgets/user_transactions.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        backgroundColor:Colors.purple,
      ),
      body:Column(
        children:[
        //chart
        Container(
          width: double.infinity,
          child: Card(
              color: Colors.purple,
              child: Text('CHART!!'),
          ),
        ),
        UserTranactions()
      ],)
    );
  }
}
