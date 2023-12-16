import 'package:client/components/cards/address_card.dart';
import 'package:client/models/address_info.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<AddressInfo> addresses;
  final void Function(String addressId) onAddressClicked;

  const Home({
    super.key,
    required this.addresses,
    required this.onAddressClicked,
  });

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Addresses',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.blue)),
          ),
          padding: const EdgeInsets.only(top: 8, bottom: 8),
        ),
        Expanded(child:
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: kBottomNavigationBarHeight * 2),
            itemCount: widget.addresses.length,
            itemBuilder: (BuildContext context, int index) {
              return AddressCard(
                addressInfo: widget.addresses[index],
                onSelect: widget.onAddressClicked,
              );
            },
          ),
        ),
      ],
    );
  }
}