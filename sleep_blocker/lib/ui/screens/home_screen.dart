import 'package:flutter/material.dart';
import 'package:sleep_blocker/data/mock_factor.dart';
import 'package:sleep_blocker/logic/calculate_sleep_health.dart';
import 'package:sleep_blocker/logic/log_service.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/ui/helpers/blocker_text.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import 'package:sleep_blocker/ui/widgets/app_button.dart';
import 'package:sleep_blocker/ui/widgets/info_tile.dart';
import 'package:sleep_blocker/ui/widgets/sleep_health.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onLogSleepTap, required this.onViewInsightsTap});

  final VoidCallback onLogSleepTap;
  final VoidCallback onViewInsightsTap;

  @override
  Widget build(BuildContext context) {
    final sleepLogs = LogService.sleepHistory;
    final habitLogs = LogService.habitHistory; 

    final result = SleepBlockerAnalyzer.analyze(
      sleepLogs: sleepLogs,
      habitLogs: habitLogs,
      factors: mockFactors
    );

    final avgDurationHours = SleepHealthCalculator.averageDurationHours(sleepLogs);
    final avgQuality = SleepHealthCalculator.averageQuality(sleepLogs);

    final lastSleep = sleepLogs.isNotEmpty ? sleepLogs.last : null;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text('Welcome to Sleep Blocker!', style: Theme.of(context).textTheme.headlineMedium),
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
                    InfoTile(title: blockerTitle(result), desc: blockerDescription(result), infoType: InfoType.blocker, onTap: onViewInsightsTap,),
                    const SizedBox(height: 40,),
                    InfoTile(title: "Personalized Advice", desc: adviceText(result), infoType: InfoType.advice, onTap: onViewInsightsTap,),
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
                "Log Sleep Now",
                onTap: onLogSleepTap
              ),
            ],
          ),
        ),
      ),
    );
  
  }
} 
