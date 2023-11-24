import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme(bool isDarkMode) {
 
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
    );
  }
}
