import 'package:flutter/material.dart';
import 'package:sleep_blocker/data/mock_factor.dart';
import 'package:sleep_blocker/data/mock_habit_log.dart';
import 'package:sleep_blocker/data/mock_sleep_log.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/ui/helpers/blocker_text.dart';
import 'package:sleep_blocker/ui/widgets/info_tile.dart';
import 'package:sleep_blocker/ui/widgets/sleep_history_item.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final result = SleepBlockerAnalyzer.analyze(
      sleepLogs: mockSleepLogs,
      habitLogs: mockHabitLogs,
      factors: mockFactors
    );
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Insight screen"),
          ),
          const SizedBox(height: 20,),
          InfoTile(title: "Key Insights", desc: insightText(result!), infoType: InfoType.insight),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: mockSleepLogs.length,
              itemBuilder: (context, index) {
                final sleepLog = mockSleepLogs[index];
            
                final habitLogsForNight = mockHabitLogs
                    .where((h) => h.sleepLogId == sleepLog.id)
                    .toList();
            
                return SleepHistoryItem(
                  sleepLog: sleepLog,
                  habitLogs: habitLogsForNight,
                  factors: mockFactors,
                );
              },
            ),
          ),
        ],
      ),
    );
  
  }
} 
