

import 'package:client/models/app_page.dart';
import 'package:flutter/material.dart';

class NotchedButton extends StatelessWidget {
  final AppPage currentPage;
  final void Function() onPressed;
  
  const NotchedButton({
    super.key,
    required this.currentPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Icon(
        _notchedButtonIcon,
      ),
    );
  }

  IconData get _notchedButtonIcon => currentPage == AppPage.home ? Icons.add : Icons.account_balance_wallet_outlined;
}