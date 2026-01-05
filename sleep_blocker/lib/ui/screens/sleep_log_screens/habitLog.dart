import 'package:flutter/material.dart';
import '../../../models/sleep_log.dart';
import '../../../models/habit_log.dart';
import '../../../logic/logService.dart';

class HabitLogScreen extends StatefulWidget {
  // 1. Catch the object from Student A
  final SleepLog sleepRecord; 

  const HabitLogScreen({super.key, required this.sleepRecord});

  @override
  State<HabitLogScreen> createState() => _HabitLogScreenState();
}

class _HabitLogScreenState extends State<HabitLogScreen> {
  // Local list to hold the habit answers before saving to the global list
  List<HabitLog> dailyHabits = [];

  void _onSaveAll() {
    // 2. Link their habit to YOUR sleep ID
    final coffeeHabit = HabitLog(
      sleepLogId: widget.sleepRecord.id, // THE LINK
      factorId: 'f1',
      value: 1, 
    );

    // 3. Save to the Global List (The Repository)
    LogService.sleepHistory.add(widget.sleepRecord);
    LogService.habitHistory.add(coffeeHabit);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habits for ${widget.sleepRecord.date.day}")),
      body: Center(child: Text("Sleep Quality: ${widget.sleepRecord.qualityScore}")),
    );
  }
}