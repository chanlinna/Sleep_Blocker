import '../models/sleep_log.dart';

enum HealthLevel { poor, okay, good }

class SleepHealthCalculator {
  static const int windowDays = 7;

  static double averageDurationHours(List<SleepLog> logs) {
    final recent = _last7(logs);
    if (recent.isEmpty) return 0;

    final total = recent.fold<double>(
      0,
      (sum, log) => sum + log.duration,
    );

    return total / recent.length;
  }

  static double averageQuality(List<SleepLog> logs) {
    final recent = _last7(logs);
    if (recent.isEmpty) return 0;

    final total = recent.fold<int>(
      0,
      (sum, log) => sum + log.qualityScore,
    );

    return total / recent.length;
  }

  static List<SleepLog> _last7(List<SleepLog> logs) {
    final sorted = [...logs]
      ..sort((a, b) => b.date.compareTo(a.date));

    return sorted.take(windowDays).toList();
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

  int sleepHealthIndex({required double avgDurationHours,required double avgQuality,}) 
  {
    final duration = durationLevel(avgDurationHours);
    final quality = qualityLevel(avgQuality);

    int score(HealthLevel level) {
      switch (level) {
        case HealthLevel.poor:
          return 0;
        case HealthLevel.okay:
          return 1;
        case HealthLevel.good:
          return 2;
      }
    }

    return score(duration) + score(quality) + 1; 
  }
}
