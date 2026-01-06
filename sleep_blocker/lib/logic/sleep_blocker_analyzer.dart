import '../models/sleep_log.dart';
import '../models/habit_log.dart';
import '../models/factor.dart';
import '../models/factor_type.dart';


class BlockerResult {
  final Factor factor;
  final double impact;
  // For binary
  final double yesAvg;
  final double noAvg;

  // For ordinal
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

    final last7SleepLogs = sleepLogs
        .sortedByDateDesc()
        .take(analysisDays)
        .toList();

    final results = <BlockerResult>[];

    for (final factor in factors) {
      if (factor.type == FactorType.screen || factor.type == FactorType.pain) {
        final impactData = _booleanImpactData(factor.factorId, last7SleepLogs, habitLogs);
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
        final impactData = _weightedImpactData(factor.factorId, last7SleepLogs, habitLogs);
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

  // ---------- BOOLEAN FACTORS ----------
  static _BooleanImpactData? _booleanImpactData(
    String factorId,
    List<SleepLog> sleepLogs,
    List<HabitLog> habitLogs,
  ) {
    final yes = <int>[];
    final no = <int>[];

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere(
        (h) => h.sleepLogId == sleep.id && h.factorId == factorId,
        orElse: () => HabitLog(sleepLogId: sleep.id, factorId: factorId, value: -1),
      );
      if (habit.value == 1) yes.add(sleep.qualityScore);
      if (habit.value == 0) no.add(sleep.qualityScore);
    }

    if (yes.length < 2 || no.length < 2) return null;

    final yesAvg = yes.average();
    final noAvg = no.average();
    final impact = yesAvg - noAvg;

    return _BooleanImpactData(impact: impact, yesAvg: yesAvg, noAvg: noAvg);
  }

  // ---------- WEIGHTED FACTORS ----------
  static _WeightedImpactData? _weightedImpactData(
    String factorId,
    List<SleepLog> sleepLogs,
    List<HabitLog> habitLogs,
  ) {
    final lowList = <int>[];
    final mediumList = <int>[];
    final highList = <int>[];

    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere((h) => h.sleepLogId == sleep.id && h.factorId == factorId);
      if (habit.value == 1) lowList.add(sleep.qualityScore);
      if (habit.value == 2) mediumList.add(sleep.qualityScore);
      if (habit.value == 3) highList.add(sleep.qualityScore);
    }

    if (lowList.length < 2) return null;
    if ((mediumList.length + highList.length) < 2) return null;

    final baseline = lowList.average();

    double sum = 0;
    for (final sleep in sleepLogs) {
      final habit = habitLogs.firstWhere((h) => h.sleepLogId == sleep.id && h.factorId == factorId);
      final weight = switch (habit.value) {
        1 => 0.0,
        2 => 0.5,
        3 => 1.0,
        _ => 0.0,
      };
      sum += weight * (sleep.qualityScore - baseline);
    }

    final impact = sum / sleepLogs.length;

    return _WeightedImpactData(
      impact: impact,
      lowAvg: lowList.average(),
      mediumAvg: mediumList.isEmpty ? lowList.average() : mediumList.average(),
      highAvg: highList.isEmpty ? lowList.average() : highList.average(),
    );
  }
}

// ---------- DATA CLASSES FOR INTERNAL USE ----------
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

  _WeightedImpactData({required this.impact, required this.lowAvg, required this.mediumAvg, required this.highAvg});
}

// ---------- HELPERS ----------
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

