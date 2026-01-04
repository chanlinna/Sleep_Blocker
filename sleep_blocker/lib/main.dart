import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/screens/main_tab_screen.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: MainTabScreen(),
    );
  }
}
