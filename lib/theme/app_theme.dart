import 'package:flutter/material.dart';
class AppTheme {
  static const textColor =  Color.fromARGB(255, 0, 0, 0);
  static const iconColor =  Color.fromARGB(255, 0, 0, 0);
  static const bottomColor =  Color.fromARGB(54, 0, 0, 0);
  static const foundColor = BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.blue,
          Colors.white,
        ],
      ));
}