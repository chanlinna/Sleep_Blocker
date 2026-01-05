import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../../models/sleep_log.dart';
import 'habitLog.dart';
import '../../widgets/calendar.dart';
import '../../widgets/sleepInput.dart';
import '../../widgets/NextButton.dart';

class SleepLogScreen extends StatefulWidget {
  const SleepLogScreen({super.key});

  @override
  State<SleepLogScreen> createState() => _SleepLogScreenState();
}

class _SleepLogScreenState extends State<SleepLogScreen> {
  DateTime selectedDate = DateTime.now();
  double duration = 6.0;
  int? qualityScore;

  void _handleNext() {
    final currentNight = SleepLog(
      date: selectedDate,
      duration: duration,
      qualityScore: qualityScore!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitLogScreen(sleepRecord: currentNight),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView( // Prevents crashing if the screen is small
          child: Column(
            children: [

              SleepCalendarHeader(
                selectedDate: selectedDate,
                onDateSelected: (date) => setState(() => selectedDate = date),
              ),

              const SizedBox(height: 20),

              SleepInputWidget(
                duration: duration,
                qualityScore: qualityScore,
                onQualitySelected: (score) => setState(() => qualityScore = score),
                onDurationChanged: (val) => setState(() => duration = val),
              ),

              const SizedBox(height: 20),

              NextButton(
                onPressed: qualityScore == null ? null : _handleNext,
              ),
            ],
          ),
        ),
      ),
    );
  }


}