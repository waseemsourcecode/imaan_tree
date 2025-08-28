import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imaan_tree/arch/clean_arch/features/notifications/notification_service.dart'; 
import 'package:imaan_tree/arch/clean_arch/presentation/screens/imaan_dashboard.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    requestNotificationPermission();
  await NotificationService.init();
  runApp(const StartApp());
}
Future<void> requestExactAlarmPermission() async {
  const platform = MethodChannel('com.example.app/permissions');
  try {
    await platform.invokeMethod('requestExactAlarmPermission');
  } on PlatformException catch (e) {
    print("Error requesting exact alarm permission: $e");
  }
}
void requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
//  requestExactAlarmPermission();
}
 
class StartApp extends StatelessWidget {
  const StartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Imaan Tree',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImaanDashboard(),
    );
  }
}

