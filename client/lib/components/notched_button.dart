

import 'package:flutter/material.dart';

class NotchedButton extends StatefulWidget {
  final IconData icon;
  final void Function() onPressed;
  
  const NotchedButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<StatefulWidget> createState() => _NotchedButtonState();
}

class _NotchedButtonState extends State<NotchedButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: widget.onPressed,
      child: Icon(
        widget.icon,
      ),
    );
  }
}