import 'package:flutter/material.dart';

class AppTheme {
  final _appTheme = ThemeData(
    useMaterial3: false,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 154, 185, 155),
      foregroundColor: Colors.white,
      hoverColor: Colors.blue,
      splashColor: Colors.white,
    ),
  );

  ThemeData getAppTheme() {
    return _appTheme;
  }
}
