import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child:Text(title));
  }
  
}