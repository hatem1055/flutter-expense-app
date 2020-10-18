import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTxForm extends StatefulWidget {
  final Function addTx;
  AddTxForm(this.addTx);

  @override
  _AddTxFormState createState() => _AddTxFormState();
}

class _AddTxFormState extends State<AddTxForm> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime dateInput = DateTime.now();

  submitForm() {
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || dateInput == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, dateInput);
    Navigator.of(context).pop();
  }

  void triggerDatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if (date == null) {
      return;
    } else {
      setState(() {
        dateInput = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    String dateMessage = dateInput == null
        ? 'No Date Choosen'
        : DateFormat.yMd().format(dateInput);

    //widgets
    Widget submitButton = RaisedButton(
      child: Text('Add Transaction'),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onPressed: () => submitForm(),
    );
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleInput,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountInput,
            ),
            Container(
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(dateMessage),
                        FlatButton(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: triggerDatePicker,
                        ),
                      ],
                    ),
                    if (isLandscape) submitButton
                  ]),
            ),
            if (!isLandscape) submitButton
          ]),
        ),
      ),
    );
  }
}
