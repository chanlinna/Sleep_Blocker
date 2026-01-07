import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/screens/home_screen.dart';
import 'package:sleep_blocker/ui/screens/insight_screen.dart';
import 'package:sleep_blocker/ui/screens/sleep_log_screens/sleep_log.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentTabIndex = 0;

  void switchToTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          HomeScreen(onLogSleepTap: () => switchToTab(1), onViewInsightsTap: () => switchToTab(2),),
          SleepLogScreen(),
          InsightScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.surfaceColor,
        selectedItemColor: AppTheme.primaryColor,
        currentIndex: _currentTabIndex,
        onTap: switchToTab,
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