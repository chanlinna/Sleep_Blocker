import 'package:sleep_blocker/models/sleep_log.dart';

final List<SleepLog> mockSleepLogs = [
  SleepLog(
    id: 'S1',
    date: DateTime(2026, 1, 1),
    duration: 6.0,
    qualityScore: 2, // low quality → weighted factors matter
  ),
  SleepLog(
    id: 'S2',
    date: DateTime(2026, 1, 2),
    duration: 7.5,
    qualityScore: 4, // high quality → contrast with bad habits
  ),
  SleepLog(
    id: 'S3',
    date: DateTime(2026, 1, 3),
    duration: 5.5,
    qualityScore: 2,
  ),
  SleepLog(
    id: 'S4',
    date: DateTime(2026, 1, 4),
    duration: 6.5,
    qualityScore: 3,
  ),
  SleepLog(
    id: 'S5',
    date: DateTime(2026, 1, 5),
    duration: 8.0,
    qualityScore: 5,
  ),
  SleepLog(
    id: 'S6',
    date: DateTime(2026, 1, 6),
    duration: 4.8,
    qualityScore: 1, // really low → emphasizes impact of noise/stress
  ),
  SleepLog(
    id: 'S7',
    date: DateTime(2026, 1, 7),
    duration: 7.0,
    qualityScore: 3,
  ),
];
