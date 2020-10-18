import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final delTx;
  final tx;
  TransactionItem({Key key,this.tx, this.delTx}) : super(key : key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: primaryColor,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              '\$${widget.tx.amount}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
        title:
            Text(widget.tx.title, style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat.yMMMd().format(widget.tx.date)),
        trailing: MediaQuery.of(context).size.width > 560
            ? FlatButton.icon(
                onPressed: () {
                  widget.delTx(widget.tx.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.delTx(widget.tx.id);
                },
              ),
      ),
    );
  }
}
