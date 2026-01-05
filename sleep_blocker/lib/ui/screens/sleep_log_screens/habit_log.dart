import 'package:flutter/material.dart';
import '../../../models/sleep_log.dart';
import '../../../models/habit_log.dart';

class HabitLogScreen extends StatefulWidget {
  final SleepLog sleepRecord; 

  const HabitLogScreen({super.key, required this.sleepRecord});

  @override
  State<HabitLogScreen> createState() => _HabitLogScreenState();
}

class _HabitLogScreenState extends State<HabitLogScreen> {
  List<HabitLog> dailyHabits = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habits for ${widget.sleepRecord.date.day}")),
      body: Center(child: Text("Sleep Quality: ${widget.sleepRecord.qualityScore}")),
    );
  }
}