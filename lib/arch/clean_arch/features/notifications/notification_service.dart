 
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print('🔔 Notification tapped!');
        print('➡️ actionId: ${response.actionId}');
        print('➡️ payload: ${response.payload}');
        print('➡️ id: ${response.id}');

        if (response.actionId == 'mark_done') {
          await markNotificationAsDone(response.id ?? 0);
        }
      },
    );

    // ✅ Initialize timezone DB
    tz.initializeTimeZones();

final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
tz.setLocalLocation(tz.getLocation(currentTimeZone));

  }

  static Future<void> showRemembranceNotification(
      int id, String title, String body) async {
    final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'remembrance_channel',
      'Remembrance',
      channelDescription: 'Reminders to align on Imaan',
      importance: Importance.max,
      priority: Priority.high,
  
      styleInformation: bigTextStyleInformation,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'mark_done',
          'Mark as Done',
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );

    final NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.show(
      id,
      title,
      body,
      details,
      payload: 'remembrance',
    );
  }

  static Future<void> markNotificationAsDone(int id) async {
    print("Marking notification $id as done...");
    // ✅ 1. Cancel (destroy) the notification from tray
    await _plugin.cancel(id);

    // ✅ 2. Add your custom logic here
    // e.g., save "done" status in database / shared_preferences
    print("Notification $id marked as done and removed.");
  }

static Future<void> scheduleLocalNotification({
  int id = 1,
  required String title,
  required String body,
  required int hour,
  required int minute
})async{

final now = tz.TZDateTime.now(tz.local);

 final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );


  final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Notifications that fire at a specific time',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'mark_done',
          'Mark as Done',
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );

    final NotificationDetails details =
        NotificationDetails(android: androidDetails);

var scheduleDate = tz.TZDateTime(tz.local, now.year,now.month,now.day,hour,minute);

await _plugin.zonedSchedule(id, title, body, scheduleDate, details,


 androidScheduleMode: AndroidScheduleMode.inexact,
 matchDateTimeComponents: DateTimeComponents.time
 );

}

Future<void> cancelAllNotification()async{
  _plugin.cancelAll();
}
  static Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
  ) async {
    final BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'Notifications that fire at a specific time',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigTextStyleInformation,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'mark_done',
          'Mark as Done',
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );

    final NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details, 
      androidScheduleMode: AndroidScheduleMode.inexact,
      payload: 'scheduled',
      matchDateTimeComponents: DateTimeComponents.dateAndTime, //for daily
    );


    
  }
}
