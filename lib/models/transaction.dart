import 'package:flutter/foundation.dart';


class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final String title;
  Transaction({
    @required this.date,
    @required this.title,
    @required this.amount,
    @required this.id});
}