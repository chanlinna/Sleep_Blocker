// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:sleep_blocker/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleep_blocker/main.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/models/sleep_log.dart';
import 'package:sleep_blocker/models/habit_log.dart';
import 'package:sleep_blocker/models/factor.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/widgets/sleep_input.dart';

void main() {
  group('SleepBlockerAnalyzer Logic Tests', () {
    test('Returns notEnoughData when fewer than 7 sleep logs', () {
      final sleepLogs = <SleepLog>[];
      final habitLogs = <HabitLog>[];
      final factors = [
        Factor(type: FactorType.screen, name: 'Phone', rotatingQuestions: [])
      ];

      final result = SleepBlockerAnalyzer.analyze(
        sleepLogs: sleepLogs,
        habitLogs: habitLogs,
        factors: factors,
      );

      expect(result.status, BlockerStatus.notEnoughData);
    });

    test('Returns noBlockerDetected if sleep logs exist but no negative impact', () {
      final sleepLogs = List.generate(
        7,
        (i) => SleepLog(
            date: DateTime.now().subtract(Duration(days: i)),
            duration: 8,
            qualityScore: 4),
      );

      // All habit values neutral (0)
      final habitLogs = List.generate(
        7,
        (i) => HabitLog(
            sleepLogId: sleepLogs[i].id, factorId: 'f1', value: 0),
      );

      final factors = [
        Factor(type: FactorType.screen, name: 'Phone', rotatingQuestions: [],
            factorId: 'f1')
      ];

      final result = SleepBlockerAnalyzer.analyze(
        sleepLogs: sleepLogs,
        habitLogs: habitLogs,
        factors: factors,
      );

      expect(result.status, BlockerStatus.noBlockerDetected);
    });

    test('Detects blocker if boolean factor negatively impacts sleep', () {
      final sleepLogs = List.generate(
        7,
        (i) => SleepLog(
            date: DateTime.now().subtract(Duration(days: i)),
            duration: 6,
            qualityScore: i < 4 ? 2 : 5), // first 4 nights low quality, last 3 high
      );

      // yes (habit = 1) corresponds to low quality sleep
      final habitLogs = [
        HabitLog(sleepLogId: sleepLogs[0].id, factorId: 'f1', value: 1),
        HabitLog(sleepLogId: sleepLogs[1].id, factorId: 'f1', value: 1),
        HabitLog(sleepLogId: sleepLogs[2].id, factorId: 'f1', value: 1),
        HabitLog(sleepLogId: sleepLogs[3].id, factorId: 'f1', value: 1),
        HabitLog(sleepLogId: sleepLogs[4].id, factorId: 'f1', value: 0),
        HabitLog(sleepLogId: sleepLogs[5].id, factorId: 'f1', value: 0),
        HabitLog(sleepLogId: sleepLogs[6].id, factorId: 'f1', value: 0),
      ];

      final factors = [
        Factor(type: FactorType.screen, name: 'Phone', rotatingQuestions: [], factorId: 'f1')
      ];

      final result = SleepBlockerAnalyzer.analyze(
        sleepLogs: sleepLogs,
        habitLogs: habitLogs,
        factors: factors,
      );

      expect(result.status, BlockerStatus.success);
      expect(result.blockers.first.factor.name, 'Phone');
    });

  //   test('Detects blocker if weighted factor negatively impacts sleep', () {
  //     final sleepLogs = List.generate(
  //       7,
  //       (i) => SleepLog(
  //           date: DateTime.now().subtract(Duration(days: i)),
  //           duration: 7,
  //           qualityScore: i < 3 ? 2 : 5), // first 3 low, last 4 high
  //     );

  //     // 0 = low, 1 = medium, 2 = high (weighted factor)
  //     final habitLogs = [
  //       HabitLog(sleepLogId: sleepLogs[0].id, factorId: 'f2', value: 2),
  //       HabitLog(sleepLogId: sleepLogs[1].id, factorId: 'f2', value: 2),
  //       HabitLog(sleepLogId: sleepLogs[2].id, factorId: 'f2', value: 2),
  //       HabitLog(sleepLogId: sleepLogs[3].id, factorId: 'f2', value: 0),
  //       HabitLog(sleepLogId: sleepLogs[4].id, factorId: 'f2', value: 0),
  //       HabitLog(sleepLogId: sleepLogs[5].id, factorId: 'f2', value: 1),
  //       HabitLog(sleepLogId: sleepLogs[6].id, factorId: 'f2', value: 1),
  //     ];

  //     final factors = [
  //       Factor(type: FactorType.pain, name: 'Stress', rotatingQuestions: [], factorId: 'f2')
  //     ];

  //     final result = SleepBlockerAnalyzer.analyze(
  //       sleepLogs: sleepLogs,
  //       habitLogs: habitLogs,
  //       factors: factors,
  //     );

  //     expect(result.status, BlockerStatus.success);
  //     expect(result.blockers.first.factor.name, 'Stress');
  //   });
  });

  group('SleepInputWidget UI Tests', () {
    testWidgets('Displays current sleep duration and updates when slider moves',
        (WidgetTester tester) async {
      double duration = 7.0;
      int? qualityScore;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SleepInputWidget(
            duration: duration,
            qualityScore: qualityScore,
            onQualitySelected: (val) => qualityScore = val,
            onDurationChanged: (val) => duration = val,
          ),
        ),
      ));

      expect(find.text('7.0 Hours'), findsOneWidget);

      final slider = find.byType(Slider);
      await tester.drag(slider, const Offset(50, 0));
      await tester.pump();

      expect(duration, isNot(7.0));
    });

    testWidgets('Selecting an emoji updates qualityScore',
        (WidgetTester tester) async {
      int? qualityScore;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SleepInputWidget(
            duration: 7,
            qualityScore: qualityScore,
            onQualitySelected: (val) => qualityScore = val,
            onDurationChanged: (_) {},
          ),
        ),
      ));

      await tester.tap(find.byIcon(Icons.sentiment_very_satisfied));
      await tester.pump();

      expect(qualityScore, 5);
    });
  });

  group('App Smoke Test', () {
    testWidgets('App loads without errors', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Insight'), findsOneWidget);
    });
  });
}
