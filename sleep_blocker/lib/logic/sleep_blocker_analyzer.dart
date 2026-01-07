import '../models/sleep_log.dart';
import '../models/habit_log.dart';
import '../models/factor.dart';
import '../models/factor_type.dart';

class BlockerResult {
  final Factor factor;
  final double impact;

  final double yesAvg;
  final double noAvg;

  final double lowAvg;
  final double mediumAvg;
  final double highAvg;

  BlockerResult({
    required this.factor,
    required this.impact,
    required this.yesAvg,
    required this.noAvg,
    required this.lowAvg,
    required this.mediumAvg,
    required this.highAvg,
  });
}

enum BlockerStatus {
  success,
  notEnoughData,
  noBlockerDetected,
}

class BlockerAnalysisResult {
  final BlockerStatus status;
  final List<BlockerResult> blockers;

  const BlockerAnalysisResult({
    required this.status,
    this.blockers = const [],
  });
}

class SleepBlockerAnalyzer {
  static const int analysisDays = 7;
  static const double impactThreshold = -0.5;

  static BlockerAnalysisResult analyze({
    required List<SleepLog> sleepLogs,
    required List<HabitLog> habitLogs,
    required List<Factor> factors,
  }) {
    if (sleepLogs.length < analysisDays) {
      return const BlockerAnalysisResult(status: BlockerStatus.notEnoughData);
    }

    final sortedLogs = List<SleepLog>.from(sleepLogs);
    sortedLogs.sort((a, b) => b.date.compareTo(a.date));
    final last7SleepLogs = sortedLogs.take(analysisDays).toList();

    final results = <BlockerResult>[];

    for (final factor in factors) {
      if (factor.type == FactorType.screen || factor.type == FactorType.pain) {
        final impactData = _calculateBooleanImpact(factor.factorId, last7SleepLogs, habitLogs);
        if (impactData != null && impactData.impact <= impactThreshold) {
          results.add(BlockerResult(
            factor: factor,
            impact: impactData.impact,
            yesAvg: impactData.yesAvg,
            noAvg: impactData.noAvg,
            lowAvg: 0,
            mediumAvg: 0,
            highAvg: 0,
          ));
        }
      } else {
        final impactData = _calculateWeightedImpact(factor.factorId, last7SleepLogs, habitLogs);
        if (impactData != null && impactData.impact <= impactThreshold) {
          results.add(BlockerResult(
            factor: factor,
            impact: impactData.impact,
            yesAvg: 0,
            noAvg: 0,
            lowAvg: impactData.lowAvg,
            mediumAvg: impactData.mediumAvg,
            highAvg: impactData.highAvg,
          ));
        }
      }
    }

    if (results.isEmpty) {
      return const BlockerAnalysisResult(status: BlockerStatus.noBlockerDetected);
    }

    results.sort((a, b) => a.impact.compareTo(b.impact));
    return BlockerAnalysisResult(status: BlockerStatus.success, blockers: results);
  }

  static _BooleanImpactData? _calculateBooleanImpact(
      String factorId, List<SleepLog> sleepLogs, List<HabitLog> habitLogs) {
    final yesScores = <int>[];
    final noScores = <int>[];

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere(
        (h) => h.sleepLogId == sleep.id && h.factorId == factorId,
        orElse: () => HabitLog(sleepLogId: sleep.id, factorId: factorId, value: -1),
      );
      if (habit.value == 1) {
        yesScores.add(sleep.qualityScore);
      } else if (habit.value == 0) {
        noScores.add(sleep.qualityScore);
      }
    }

    if (yesScores.length < 2 || noScores.length < 2) {
      return null;
    }

    final yesAvg = _average(yesScores);
    final noAvg = _average(noScores);
    final impact = yesAvg - noAvg;

    return _BooleanImpactData(impact: impact, yesAvg: yesAvg, noAvg: noAvg);
  }

  static _WeightedImpactData? _calculateWeightedImpact(
    String factorId, List<SleepLog> sleepLogs, List<HabitLog> habitLogs) {
      final lowScores = <int>[];
      final mediumScores = <int>[];
      final highScores = <int>[];

      for (final sleep in sleepLogs) {
        final habit = habitLogs.firstWhere((h) => h.sleepLogId == sleep.id && h.factorId == factorId);
        if (habit.value == 0) {
          lowScores.add(sleep.qualityScore);
        } else if (habit.value == 1) {
          mediumScores.add(sleep.qualityScore);
        } else if (habit.value == 2) {
          highScores.add(sleep.qualityScore);
        }
      }

      if (lowScores.length < 2 || (mediumScores.length + highScores.length) < 2) {
        return null;
      }

      final baseline = _average(lowScores);
      double sumImpact = 0;

      for (final sleep in sleepLogs) {
        final habit = habitLogs.firstWhere((h) => h.sleepLogId == sleep.id && h.factorId == factorId);
        double weight = 0.0;
        if (habit.value == 0) weight = 0.0;
        if (habit.value == 1) weight = 0.5;
        if (habit.value == 2) weight = 1.0;

        sumImpact += weight * (sleep.qualityScore - baseline);
      }

      final impact = sumImpact / sleepLogs.length;

      final lowAvg = _average(lowScores);
      final mediumAvg = mediumScores.isEmpty ? lowAvg : _average(mediumScores);
      final highAvg = highScores.isEmpty ? lowAvg : _average(highScores);

      return _WeightedImpactData(
        impact: impact,
        lowAvg: lowAvg,
        mediumAvg: mediumAvg,
        highAvg: highAvg,
      );
  }

  static double _average(List<int> numbers) {
    final total = numbers.fold<int>(0, (sum, item) => sum + item);
    return total / numbers.length;
  }
}

class _BooleanImpactData {
  final double impact;
  final double yesAvg;
  final double noAvg;

  _BooleanImpactData({required this.impact, required this.yesAvg, required this.noAvg});
}

class _WeightedImpactData {
  final double impact;
  final double lowAvg;
  final double mediumAvg;
  final double highAvg;

  _WeightedImpactData({
    required this.impact,
    required this.lowAvg,
    required this.mediumAvg,
    required this.highAvg,
  });
}
