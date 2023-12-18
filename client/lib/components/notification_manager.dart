import 'package:flutter/material.dart';

class NotificationManager {
  static final NotificationManager _notificationManager = NotificationManager._internal();

  late BuildContext? _buildContext;

  factory NotificationManager() {
    return _notificationManager;
  }

  NotificationManager._internal();

  set buildContext(BuildContext ctx) => _buildContext = ctx;

  void fireNotification(String message) {
    if (_buildContext == null) return;

    final notification = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(_buildContext!).showSnackBar(notification);
  }
}