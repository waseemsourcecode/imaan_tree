import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.actionId == 'mark_done') {
          // Handle mark as done action
          markNotificationAsDone(response.id ?? 0);
        }
      },
    );
  }

  static Future<void> showRemembranceNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'remembrance_channel',
      'Remembrance',
      channelDescription: 'Reminders to align on Imaan',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('mark_done', 'Mark as Done'),
      ],
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id,
      title,
      body,
      details,
      payload: 'remembrance',
    );
  }

  static Future<void> markNotificationAsDone(int id) async {
    // Update your tracking logic here (e.g., database, shared_preferences)
    // This is called when user taps "Mark as Done" in the notification
  }
}