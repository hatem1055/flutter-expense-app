import 'package:flutter/material.dart';

class AddTxForm extends StatelessWidget {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();

  final Function addTx;
  AddTxForm(this.addTx);
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
              ),
              TextField(       
                decoration:InputDecoration(labelText:'Amount'),
                keyboardType:TextInputType.number,
                controller:amountInput,
                ),
                FlatButton(
                  child: Text('Add Transaction'),
                  textColor:Colors.purple,
                  onPressed:(){
                    var amount = double.parse(amountInput.text);
                    addTx(titleInput.text,amount);
                  },
                )
            ]
            ),
          ),
        );
  }
}