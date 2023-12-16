import 'package:flutter/material.dart';

class AddAddressDialog extends StatefulWidget {
  final void Function(String) onAddAddress;

  const AddAddressDialog({
    super.key,
    required this.onAddAddress,
  });

  @override
  State<StatefulWidget> createState() => _AddAddressDialog();
}

class _AddAddressDialog extends State<AddAddressDialog> {
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();

    return AlertDialog(
      title: const Row(children: [
        Icon(Icons.account_balance_wallet_outlined),
        SizedBox(width: 8),
        Text('New Address'),
      ]),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Add address...'),
          controller: textEditingController,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _closeDialog(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAddAddress(textEditingController.text);
            _closeDialog(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _closeDialog(BuildContext context) => Navigator.of(context).pop();
}