import 'package:client/components/cards/address_overview_card.dart';
import 'package:client/components/cards/transaction_card.dart';
import 'package:client/models/address_info.dart';
import 'package:flutter/material.dart';

class Addresses extends StatefulWidget {
  final AddressInfo addressInfo;
  final void Function(String) onTitleEdit;

  const Addresses({
    super.key,
    required this.addressInfo,
    required this.onTitleEdit,
  });

  @override
  State<StatefulWidget> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.blue)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
            child: AddressOverviewCard(
              addressInfo: widget.addressInfo,
              onTitleEdit: widget.onTitleEdit,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Center(child: Text(
            'Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: kBottomNavigationBarHeight * 2),
            itemCount: widget.addressInfo.transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionCard(
                transaction: widget.addressInfo.transactions[index],
              );
            },
          ),
        ),
      ],
    );
  }
}