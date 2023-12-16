import 'package:flutter/material.dart';

class DeleteAddressDialog extends StatefulWidget {
  final void Function() onDelete;

  const DeleteAddressDialog({
    super.key,
    required this.onDelete,
  });

  @override
  State<StatefulWidget> createState() => _DeleteAddressDialogState();
}

class _DeleteAddressDialogState extends State<DeleteAddressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(children: [
        Icon(Icons.delete),
        SizedBox(width: 8),
        Text('Delete Address'),
      ]),
      content: const Text('Are you sure you want to delete this address?'),
      actions: [
        TextButton(
          onPressed: () => _closeDialog(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onDelete();
            _closeDialog(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void _closeDialog(BuildContext context) => Navigator.of(context).pop();
}