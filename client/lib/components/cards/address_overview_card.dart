import 'package:client/components/dialogs/edit_title_dialog.dart';
import 'package:client/utils/address_info.dart';
import 'package:client/utils/currency_converter.dart';
import 'package:flutter/material.dart';

class AddressOverviewCard extends StatefulWidget {
  final AddressInfo addressInfo;
  final void Function(String) onTitleEdit;

  const AddressOverviewCard({
    super.key,
    required this.addressInfo,
    required this.onTitleEdit,
  });

  @override
  State<StatefulWidget> createState() => _AddressOverviewCardState();
}

class _AddressOverviewCardState extends State<AddressOverviewCard> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.addressInfo.title;
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.addressInfo.title, addressId = widget.addressInfo.id;
    if (title.isEmpty) {
      title = addressId;
      addressId = '';
    }

    return Card(
      elevation: 4.0,
      color: Colors.blue.shade200,
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              addressId,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            trailing: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => EditTitleDialog(
                  currentTitle: widget.addressInfo.title,
                  onConfirm: _onTitleEdit,
                ),
              ),
              icon: const Icon(Icons.edit, color: Colors.black),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              currencyString(widget.addressInfo.balance),
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
  
  void _onTitleEdit(String newTitle) {
    setState(() => title = newTitle);
    widget.onTitleEdit(newTitle);
  }

}