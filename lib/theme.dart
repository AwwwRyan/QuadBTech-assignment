import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF090808);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primarySwatch: Colors.blue,
    );
  }
} 