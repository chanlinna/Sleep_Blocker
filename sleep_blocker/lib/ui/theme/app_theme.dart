import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2DD4BF);     
  static const Color primaryHover = Color(0xFF28B19F);    
  static const Color highRiskColor = Color(0xFFF87171);    
  static const Color surfaceColor = Color(0xFF1E293B);    
  static const Color backgroundColor = Color(0xFF0F172A);  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF9E9E9E);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textPrimary),
      bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
      bodySmall: TextStyle(fontSize: 10, color: Color(0xFFA8A3A3))
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.pressed) ? primaryHover : primaryColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 14, horizontal: 20)),
      ),
    ),
    cardColor: surfaceColor,
  );
}
