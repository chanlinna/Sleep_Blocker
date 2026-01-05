import 'package:flutter/material.dart';
import 'package:horizontal_weekly_calendar/weekly_calendar.dart'; 
import '../theme/app_theme.dart';

class SleepCalendarHeader extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const SleepCalendarHeader({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalWeeklyCalendar(
      initialDate: DateTime.now(),
      selectedDate: selectedDate,
      onDateSelected: onDateSelected, 
      onNextMonth: () {
        onDateSelected(DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day));
      },
      onPreviousMonth: () {
        onDateSelected(DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day));
      },
      maxDate: DateTime.now(),
      minDate: DateTime(2025, 1, 1),
      calendarStyle: HorizontalCalendarStyle(
        activeDayColor: AppTheme.primaryColor,
        selectedDayTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        monthHeaderStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}