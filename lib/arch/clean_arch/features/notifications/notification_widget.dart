import 'package:flutter/material.dart';
import 'package:imaan_tree/arch/clean_arch/features/notifications/notification_service.dart';

class NotificationModel {
  final String title;
  final String body;
  final int id;
  bool isDone;

  NotificationModel({
    required this.title,
    required this.body,
    required this.id,
    this.isDone = false,
  });
}

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // Trigger a test notification
              await NotificationService.showRemembranceNotification(
                notification.id,
                notification.title,
                notification.body,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Test notification sent!")),
              );
            },
            child: const Text("Send Test Notification"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: notification.isDone
                ? null
                : () async {
                    // Mark as done
                    final scheduledTime =
                        DateTime.now().add(Duration(minutes: 5));

                    NotificationService.scheduleNotification(
                      200,
                      "Evening Reminder",
                      "Time for your remembrance ✨",
                      scheduledTime,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Test schedulr")),
                    );
                  },
            child: const Text("Test schedule Notification"),
          ),
        ],
      ),
    );
  }
}
