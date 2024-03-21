import 'package:flutter/material.dart';
import 'package:elegant_notification/elegant_notification.dart';

enum NotificationType { success, error }


class NotificationHelper {
  static void showNotification(BuildContext context, String title, NotificationType type) {
    switch (type) {
      case NotificationType.success:
        ElegantNotification.success(
          title: Text(title),
          description: const SizedBox.shrink(),
        ).show(context);
        break;
      case NotificationType.error:
        ElegantNotification.error(
          title: Text(title),
          description: const SizedBox.shrink(),
        ).show(context);
        break;
    }
  }
}
