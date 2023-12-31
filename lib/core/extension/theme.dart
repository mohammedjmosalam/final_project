import 'package:flutter/material.dart';

extension AppTheme on ThemeData {
  Color get iconAndTextColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black;
  Color get backgroundAppColor => brightness == Brightness.dark
      ? const Color.fromARGB(255, 44, 43, 43)
      : Color.fromARGB(255, 244, 241, 241);
  Color get buttonColor => const Color.fromARGB(255, 226, 73, 124);
}
