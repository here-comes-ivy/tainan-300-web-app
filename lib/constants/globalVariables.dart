import 'package:flutter/material.dart';

class GlobalColors {
  static const Color primaryColor = Color(0xFFFF6D18);
  static const Color textColor = Color(0xFF4d4c4c);
  static const Color warningCardColor = Color.fromRGBO(238, 240, 239, 1);
  static Color warningCardTextColor = Colors.grey[700]!;
  static TextStyle globalTextStyle = const TextStyle(
    color: textColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
