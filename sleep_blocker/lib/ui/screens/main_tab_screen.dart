import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/screens/home_screen.dart';
import 'package:sleep_blocker/ui/screens/insight_screen.dart';
import 'package:sleep_blocker/ui/screens/sleep_log_screens/sleep_log_step1.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sleep Blocker')),
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          HomeScreen(),
          SleepLogStep1(),
          InsightScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.primaryColor,
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bed), 
            label: 'Sleep Log'),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights), 
            label: 'Insight'),
         
        ],
      ),
    );
  }
}