import '../models/sleep_log.dart';
import '../models/habit_log.dart';
import '../data/mock_sleep_log.dart';
import '../data/mock_habit_log.dart';

class LogService {
  static List<SleepLog> sleepHistory = List.from(mockSleepLogs);

  static List<HabitLog> habitHistory = List.from(mockHabitLogs);

  static void saveFullNight(SleepLog sleep, List<HabitLog> habits) {
    sleepHistory.add(sleep);
    habitHistory.addAll(habits);
  }
}