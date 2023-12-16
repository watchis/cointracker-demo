import 'package:client/models/currency_converter.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  State<StatefulWidget> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.transaction.id),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(currencyString(widget.transaction.transferAmount)),
          ),
        ],
      ),
    );
  }
}