import 'package:flutter/material.dart';
import 'package:sleep_blocker/data/mock_factor.dart';
import 'package:sleep_blocker/data/mock_habit_log.dart';
import 'package:sleep_blocker/data/mock_sleep_log.dart';
import 'package:sleep_blocker/logic/calculate_sleep_health.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/ui/helpers/blocker_text.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import 'package:sleep_blocker/ui/widgets/app_button.dart';
import 'package:sleep_blocker/ui/widgets/info_tile.dart';
import 'package:sleep_blocker/ui/screens/sleep_log_screens/sleep_log.dart';
import 'package:sleep_blocker/ui/widgets/section_title.dart';
import 'package:sleep_blocker/ui/widgets/sleep_health.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = SleepBlockerAnalyzer.analyze(
      sleepLogs: mockSleepLogs,
      habitLogs: mockHabitLogs,
      factors: mockFactors
    );

    final avgDurationHours = SleepHealthCalculator.averageDurationHours(mockSleepLogs);
    final avgQuality = SleepHealthCalculator.averageQuality(mockSleepLogs);

    final lastSleep = mockSleepLogs.isNotEmpty ? mockSleepLogs.last : null;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text('Welcome to Sleep Blocker!', style: Theme.of(context).textTheme.headlineMedium),
            //const SizedBox(height: 8),
            if (lastSleep != null)
              Text(
                "You slept ${lastSleep.duration.toStringAsFixed(1)} hours last night",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 20),
            Image.asset(
              '../../assets/images/welcome_logo.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  InfoTile(title: blockerTitle(result), desc: blockerDescription(result), infoType: InfoType.blocker),
                  const SizedBox(height: 40,),
                  InfoTile(title: "Personalized Advice", desc: adviceText(result), infoType: InfoType.advice),
                ]
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Sleep Health', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 16))
            ),
            const SizedBox(height: 5),
            Align(  
              alignment: Alignment.centerLeft,
              child: Text(
                'For the last 7 days',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),

            SleepHealth(avgDurationHours: avgDurationHours, avgQuality: avgQuality),
            const SizedBox(height: 20,),
            AppButton(
              "Log Sleep Here",
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SleepLogScreen(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  
  }
} 
