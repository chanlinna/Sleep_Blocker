import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../../models/sleep_log.dart';
import 'habit_log.dart';
import '../../widgets/calendar.dart';
import '../../widgets/sleep_input.dart';
import '../../widgets/app_button.dart';
import '../../../logic/log_service.dart';
import '../../widgets/success.dart';

class SleepLogScreen extends StatefulWidget {
  const SleepLogScreen({super.key});

  @override
  State<SleepLogScreen> createState() => _SleepLogScreenState();
}

class _SleepLogScreenState extends State<SleepLogScreen> {
  DateTime selectedDate = DateTime.now();
  double duration = 6.0;
  int? qualityScore;
  bool isEditing = false;

  void _handleNext() {
    final currentNight = SleepLog(
      date: selectedDate,
      duration: duration,
      qualityScore: qualityScore!,
    );

    // actually changed ?
    final existingLog = LogService.sleepHistory.firstWhere(
      (log) => isSameDate(log.date, selectedDate),
      orElse: () => null as dynamic,
    );

    if (existingLog != null && existingLog.duration == duration && existingLog.qualityScore == qualityScore) {
      setState(() => isEditing = false); 
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitLogScreen(sleepRecord: currentNight),
      ),
    );
  }

  bool get isDateLogged {
    return LogService.sleepHistory.any((log) =>
        log.date.year == selectedDate.year &&
        log.date.month == selectedDate.month &&
        log.date.day == selectedDate.day);
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
                  onDateSelected: (date){
                    setState(() {
                      selectedDate = date;
                      qualityScore = null; 
                      duration = 6.0; 
                      isEditing = false;
                    });
                  }
                ),

              const SizedBox(height: 20),
              if (isDateLogged && !isEditing)
                SuccessWidget(
                  onReLog: () {
                    final existingLog = LogService.sleepHistory.firstWhere(
                      (log) => isSameDate(log.date, selectedDate)
                    );

                    setState(() {
                      duration = existingLog.duration;
                      qualityScore = existingLog.qualityScore;
                      isEditing = true;
                    });
                 },
                ) 
              else ...[
                SleepInputWidget(
                  duration: duration,
                  qualityScore: qualityScore,
                  onQualitySelected: (score) => setState(() => qualityScore = score),
                  onDurationChanged: (val) => setState(() => duration = val),
                ),

                const SizedBox(height: 20),

                AppButton(
                  "Next",
                  onTap: qualityScore == null 
                    ? null 
                    : () => _handleNext(),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
         date1.month == date2.month &&
         date1.day == date2.day;
}
}

