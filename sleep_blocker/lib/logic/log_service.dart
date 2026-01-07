import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; 
import '../models/sleep_log.dart';
import '../models/habit_log.dart';

class LogService {
  static List<SleepLog> sleepHistory = [];
  static List<HabitLog> habitHistory = [];

  // keys to identify our data in the browser's storage
  static const String _sleepKey = 'sleep_logs_data';
  static const String _habitKey = 'habit_logs_data';

  static Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final String? sleepJson = prefs.getString(_sleepKey);
      if (sleepJson != null && sleepJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(sleepJson);
        sleepHistory = decoded.map((item) => SleepLog.fromJson(item)).toList();
        print("WEB LOAD SUCCESS: Found ${sleepHistory.length} logs.");
      }

      final String? habitJson = prefs.getString(_habitKey);
      if (habitJson != null && habitJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(habitJson);
        habitHistory = decoded.map((item) => HabitLog.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error loading data from SharedPreferences: $e");
    }
  }

  static Future<void> saveFullNight(SleepLog sleep, List<HabitLog> habits) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Update local lists (avoiding duplicates)
      sleepHistory.removeWhere((log) => 
        log.date.year == sleep.date.year && 
        log.date.month == sleep.date.month && 
        log.date.day == sleep.date.day
      );
      habitHistory.removeWhere((h) => h.sleepLogId == sleep.id);

      sleepHistory.add(sleep);
      habitHistory.addAll(habits);

      final sleepData = jsonEncode(sleepHistory.map((s) => s.toJson()).toList());
      final habitData = jsonEncode(habitHistory.map((h) => h.toJson()).toList());

      // Save to SharedPreferences 
      await prefs.setString(_sleepKey, sleepData);
      await prefs.setString(_habitKey, habitData);

      print("WEB SAVE SUCCESS: Data stored in LocalStorage.");
    } catch (e) {
      print("Error saving to SharedPreferences: $e");
    }
  }
}