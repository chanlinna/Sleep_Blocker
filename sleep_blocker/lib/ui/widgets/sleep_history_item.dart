import 'package:flutter/material.dart';
import 'package:sleep_blocker/models/factor.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/models/habit_log.dart';
import 'package:sleep_blocker/models/sleep_log.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import 'package:sleep_blocker/ui/widgets/factor_icon_row.dart';

class SleepHistoryItem extends StatelessWidget {
  final SleepLog sleepLog;
  final List<HabitLog> habitLogs;
  final List<Factor> factors;

  const SleepHistoryItem({
    super.key,
    required this.sleepLog,
    required this.habitLogs,
    required this.factors,
  });

  @override
  Widget build(BuildContext context) {
    final activeFactorTypes = _getActiveFactorTypes();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF3DE0C5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            sleepLog.duration.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        title: Text(
          _formatDate(sleepLog.date),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              'Quality: ${sleepLog.qualityScore}/5',
              style: const TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 12),
            FactorIconsRow(factors: activeFactorTypes),
          ],
        ),
      ),
    );
  }

  List<FactorType> _getActiveFactorTypes() {
      return habitLogs.where((log) => log.value > 0).map((log) {
        final factor = factors.firstWhere(
          (f) => f.factorId == log.factorId,
        );
        return factor.type;
      })
      .toSet().toList();
    }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
