import 'package:flutter/material.dart';
import 'package:sleep_blocker/models/factor.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/models/habit_log.dart';
import 'package:sleep_blocker/models/sleep_log.dart';
import 'package:sleep_blocker/ui/widgets/factor_icon_row.dart';

class SleepHistoryTile extends StatelessWidget {
  final SleepLog sleepLog;
  final List<HabitLog> habitLogs;
  final List<Factor> factors;

  const SleepHistoryTile({
    super.key,
    required this.sleepLog,
    required this.habitLogs,
    required this.factors
  });

  @override
  Widget build(BuildContext context) {
    final activeFactorTypes = _getActiveFactorTypes();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_formatDate(sleepLog.date),
            style: Theme.of(context).textTheme.bodyMedium
          ),
          Text(
            '${sleepLog.duration.toString()} h',
            style: Theme.of(context).textTheme.bodyMedium
          ),
          Text(
            '${sleepLog.qualityScore}/5',
            style: Theme.of(context).textTheme.bodyMedium
          ),
          FactorIconsRow(factors: activeFactorTypes),
        ],
      ),
    );
  }

  List<FactorType> _getActiveFactorTypes() {
    return habitLogs
        .where((log) =>
            log.sleepLogId == sleepLog.id && log.value > 0)
        .map((log) {
          final factor = factors.firstWhere(
            (f) => f.factorId == log.factorId,
          );
          return factor.type;
        })
        .toSet()
        .toList();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}