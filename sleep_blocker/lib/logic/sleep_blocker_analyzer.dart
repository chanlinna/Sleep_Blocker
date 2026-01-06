import '../models/sleep_log.dart';
import '../models/habit_log.dart';
import '../models/factor.dart';
import '../models/factor_type.dart';


class BlockerResult {
  final Factor factor;
  final double impact;

  BlockerResult({
    required this.factor,
    required this.impact,
  });
}

enum BlockerStatus {
  success,
  notEnoughData,
  noBlockerDetected,
}

class BlockerAnalysisResult {
  final BlockerStatus status;
  final BlockerResult? blocker;

  const BlockerAnalysisResult({
    required this.status,
    this.blocker,
  });
}


class SleepBlockerAnalyzer {
  static const int windowSize = 7;
  static const double impactThreshold = -0.5;

  static BlockerAnalysisResult? analyze({
    required List<SleepLog> sleepLogs,
    required List<HabitLog> habitLogs,
    required List<Factor> factors,
  }) {
    if (sleepLogs.length < windowSize){
      return const BlockerAnalysisResult(status: BlockerStatus.notEnoughData);
    }

    final last7SleepLogs = sleepLogs
        .sortedByDateDesc()
        .take(windowSize)
        .toList();

    final results = <BlockerResult>[];

    for (final factor in factors) {
      final impact = _calculateFactorImpact(
        factor,
        last7SleepLogs,
        habitLogs,
      );

      if (impact != null && impact <= impactThreshold) {
        results.add(BlockerResult(factor: factor, impact: impact));
      }
    }

    if (results.isEmpty){
      return const BlockerAnalysisResult(status: BlockerStatus.noBlockerDetected);
    }

    results.sort((a, b) => a.impact.compareTo(b.impact));
    return BlockerAnalysisResult(status: BlockerStatus.success, blocker: results.first);
  }

  static double? _calculateFactorImpact(
    Factor factor,
    List<SleepLog> sleepLogs,
    List<HabitLog> habitLogs,
  ) {
    switch (factor.type) {
      case FactorType.screen:
      case FactorType.pain:
        return _booleanImpact(factor.factorId, sleepLogs, habitLogs);

      case FactorType.noise:
      case FactorType.stress:
        return _weightedImpact(factor.factorId, sleepLogs, habitLogs);
    }
  }

  static double? _booleanImpact(
    String factorId,
    List<SleepLog> sleepLogs,
    List<HabitLog> habitLogs,
  ) {
    final yes = <int>[];
    final no = <int>[];

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere(
        (h) => h.sleepLogId == sleep.id && h.factorId == factorId,
        orElse: () => HabitLog(
          sleepLogId: sleep.id,
          factorId: factorId,
          value: -1,
        ),
      );

      if (habit.value == 1) yes.add(sleep.qualityScore);
      if (habit.value == 0) no.add(sleep.qualityScore);
    }

    if (yes.length < 2 || no.length < 2) return null;

    final yesAvg = yes.average();
    final noAvg = no.average();

    return yesAvg - noAvg;
  }

  static double? _weightedImpact(
    String factorId,
    List<SleepLog> sleepLogs,
    List<HabitLog> habitLogs,
  ) {
    int low = 0;
    int medium = 0;
    int high = 0;
    final lowQualities = <int>[];

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere(
        (h) => h.sleepLogId == sleep.id && h.factorId == factorId,
      );

      if (habit.value == 1) {
        low++;
        lowQualities.add(sleep.qualityScore);
      }
      else if (habit.value == 2) {
        medium++;
      }
      else if (habit.value == 3) {
        high++;
      }
    }

    if (low < 2) return null;
    if ((medium + high) < 2) return null;

    final baseline = lowQualities.average();

    double sum = 0;

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere(
        (h) => h.sleepLogId == sleep.id && h.factorId == factorId,
      );

      final weight = switch (habit.value) {
        1 => 0.0,
        2 => 0.5,
        3 => 1.0,
        _ => 0.0,
      };

      sum += weight * (sleep.qualityScore - baseline);
    }

    return sum / sleepLogs.length;
  }
}

extension Average on List<int> {
  double average() => reduce((a, b) => a + b) / length;
}

extension SortSleepLogs on List<SleepLog> {
  List<SleepLog> sortedByDateDesc() {
    final copy = [...this];
    copy.sort((a, b) => b.date.compareTo(a.date));
    return copy;
  }
}
