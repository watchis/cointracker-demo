import 'package:client/models/address_info.dart';
import 'package:client/models/currency_converter.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatefulWidget {
  final AddressInfo addressInfo;
  final void Function(String) onSelect;

  const AddressCard({
    super.key,
    required this.addressInfo,
    required this.onSelect,
  });

  @override
  State<StatefulWidget> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    var title = widget.addressInfo.title, addressId = widget.addressInfo.id;
    if (title.isEmpty) {
      title = addressId;
      addressId = '';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              onTap: () => widget.onSelect(widget.addressInfo.id),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 185, maxWidth: 185),
                    child: Text(
                      addressId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 140, maxWidth: 140),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${currencyString(widget.addressInfo.balance)} BTC',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
