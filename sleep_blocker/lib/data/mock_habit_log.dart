import 'package:sleep_blocker/models/habit_log.dart';

final List<HabitLog> mockHabitLogs = [
  // Night 1
  HabitLog(sleepLogId: "S1", factorId: "F1", value: 1), // screen yes
  HabitLog(sleepLogId: "S1", factorId: "F2", value: 1), // pain yes
  HabitLog(sleepLogId: "S1", factorId: "F3", value: 0), // noise low
  HabitLog(sleepLogId: "S1", factorId: "F4", value: 0), // stress low

  // Night 2
  HabitLog(sleepLogId: "S2", factorId: "F1", value: 0), // screen no
  HabitLog(sleepLogId: "S2", factorId: "F2", value: 0), // pain no
  HabitLog(sleepLogId: "S2", factorId: "F3", value: 1), // noise medium
  HabitLog(sleepLogId: "S2", factorId: "F4", value: 1), // stress medium

  // Night 3
  HabitLog(sleepLogId: "S3", factorId: "F1", value: 1),
  HabitLog(sleepLogId: "S3", factorId: "F2", value: 1),
  HabitLog(sleepLogId: "S3", factorId: "F3", value: 2), // noise high
  HabitLog(sleepLogId: "S3", factorId: "F4", value: 2), // stress high

  // Night 4
  HabitLog(sleepLogId: "S4", factorId: "F1", value: 0),
  HabitLog(sleepLogId: "S4", factorId: "F2", value: 1),
  HabitLog(sleepLogId: "S4", factorId: "F3", value: 0),
  HabitLog(sleepLogId: "S4", factorId: "F4", value: 1),

  // Night 5
  HabitLog(sleepLogId: "S5", factorId: "F1", value: 1),
  HabitLog(sleepLogId: "S5", factorId: "F2", value: 0),
  HabitLog(sleepLogId: "S5", factorId: "F3", value: 1),
  HabitLog(sleepLogId: "S5", factorId: "F4", value: 0),

  // Night 6
  HabitLog(sleepLogId: "S6", factorId: "F1", value: 1),
  HabitLog(sleepLogId: "S6", factorId: "F2", value: 1),
  HabitLog(sleepLogId: "S6", factorId: "F3", value: 2),
  HabitLog(sleepLogId: "S6", factorId: "F4", value: 2),

  // Night 7
  HabitLog(sleepLogId: "S7", factorId: "F1", value: 0),
  HabitLog(sleepLogId: "S7", factorId: "F2", value: 0),
  HabitLog(sleepLogId: "S7", factorId: "F3", value: 1),
  HabitLog(sleepLogId: "S7", factorId: "F4", value: 1),
];
