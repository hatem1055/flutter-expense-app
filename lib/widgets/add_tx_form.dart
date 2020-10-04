import 'package:flutter/material.dart';

class AddTxForm extends StatefulWidget {
  final Function addTx;
  AddTxForm(this.addTx);

  @override
  _AddTxFormState createState() => _AddTxFormState();
}

class _AddTxFormState extends State<AddTxForm> {
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  submitForm(){
      print('object');
      final enteredTitle = titleInput.text;
      final enteredAmount = double.parse(amountInput.text);
      if(enteredAmount <= 0 || enteredTitle.isEmpty){
        return;
      }
      widget.addTx(enteredTitle,enteredAmount);
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.end,
            children:[
              TextField(
                decoration:InputDecoration(labelText:'Title'),
                controller:titleInput,
                onSubmitted:(_) => submitForm(),
              ),
              TextField(       
                decoration:InputDecoration(labelText:'Amount'),
                keyboardType:TextInputType.number,
                controller:amountInput,
                onSubmitted:(_) => submitForm(),
                ),
                FlatButton(
                  child: Text('Add Transaction'),
                  textColor:Theme.of(context).primaryColor,
                  onPressed:() => submitForm(),
                )
            ]
            ),
          ),
        );
  }
}