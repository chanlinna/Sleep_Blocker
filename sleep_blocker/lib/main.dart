import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/screens/main_tab_screen.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import './logic/log_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for path_provider
  await LogService.loadData(); // Load previous logs
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: MainTabScreen(),
    );
  }
}
