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
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.text = widget.currentTitle.isEmpty ? '' : widget.currentTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          controller: _textEditingController,
          onChanged: (text) => _textEditingController.text = text,
          onSaved: (text) => _textEditingController.text = text ?? '',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _closeDialog(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(_textEditingController.text);
            _closeDialog(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _closeDialog(BuildContext context) => Navigator.of(context).pop();
}