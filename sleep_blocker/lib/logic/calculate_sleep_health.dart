import '../models/sleep_log.dart';

enum HealthLevel { poor, okay, good }

class SleepHealthCalculator {
  static const int windowDays = 7;

  static double averageDurationHours(List<SleepLog> logs) {
    final recentLogs = _last7(logs);
    if (recentLogs.isEmpty) return 0;

    double total = 0;
    for (final log in recentLogs) {
      total += log.duration;
    }

    return total / recentLogs.length;
  }

  static double averageQuality(List<SleepLog> logs) {
    final recentLogs = _last7(logs);
    if (recentLogs.isEmpty) return 0;

    int totalScore = 0;
    for (final log in recentLogs) {
      totalScore += log.qualityScore;
    }

    return totalScore / recentLogs.length;
  }

  static List<SleepLog> _last7(List<SleepLog> logs) {
    final sortedLogs = List<SleepLog>.from(logs);
    sortedLogs.sort((a, b) => b.date.compareTo(a.date));
    return sortedLogs.take(windowDays).toList();
  }

  HealthLevel durationLevel(double avgHours) {
    if (avgHours >= 7) return HealthLevel.good;
    if (avgHours >= 6) return HealthLevel.okay;
    return HealthLevel.poor;
  }

  HealthLevel qualityLevel(double avgQuality) {
    if (avgQuality >= 4.0) return HealthLevel.good;
    if (avgQuality >= 3.0) return HealthLevel.okay;
    return HealthLevel.poor;
  }

  int sleepHealthIndex({
    required double avgDurationHours,
    required double avgQuality,
  }) {
    final duration = durationLevel(avgDurationHours);
    final quality = qualityLevel(avgQuality);

    int score(HealthLevel level) {
      if (level == HealthLevel.poor) return 0;
      if (level == HealthLevel.okay) return 1;
      return 2; 
    }

    return score(duration) + score(quality) + 1; 
  }
}
