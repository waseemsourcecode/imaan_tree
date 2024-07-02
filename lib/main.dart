import 'package:flutter/material.dart';
import 'package:imaan_tree/arch/clean_arch/presentation/screens/home/screen_home.dart';
 
void main() {
  runApp(const StartApp());
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
      home: const ScreenHome(title: 'Imaan Home Page'),
    );
  }
}

