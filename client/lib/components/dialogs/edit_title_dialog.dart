import 'package:flutter/material.dart';

class EditTitleDialog extends StatefulWidget {
  final String currentTitle;
  final void Function(String) onConfirm;

  const EditTitleDialog({
    super.key,
    required this.currentTitle,
    required this.onConfirm,
  });

  @override
  State<StatefulWidget> createState() => _EditTitleDialogState();
}

class _EditTitleDialogState extends State<EditTitleDialog> {


  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(
      text: widget.currentTitle.isEmpty ? null : widget.currentTitle,
    );

    return AlertDialog(
      title: const Row(children: [
        Icon(Icons.account_balance_wallet_outlined),
        SizedBox(width: 8),
        Text('Edit Address Title'),
      ]),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Add a title...'),
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
            widget.onConfirm(textEditingController.text);
            _closeDialog(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _closeDialog(BuildContext context) => Navigator.of(context).pop();
}