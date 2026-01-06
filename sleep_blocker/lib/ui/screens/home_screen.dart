import 'package:flutter/material.dart';
import 'package:sleep_blocker/data/mock_factor.dart';
import 'package:sleep_blocker/data/mock_habit_log.dart';
import 'package:sleep_blocker/data/mock_sleep_log.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/helpers/blocker_text.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import 'package:sleep_blocker/ui/widgets/app_button.dart';
import 'package:sleep_blocker/ui/widgets/info_tile.dart';
import 'package:sleep_blocker/ui/widgets/question_tile.dart';
import 'package:sleep_blocker/ui/screens/sleep_log_screens/sleep_log.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = SleepBlockerAnalyzer.analyze(
      sleepLogs: mockSleepLogs,
      habitLogs: mockHabitLogs,
      factors: mockFactors
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text("Home screen"),
            ),
            QuestionTile(question: 'adsjha', options: [AnswerOption(text: 'Yes', selectedBgColor: Color(0xFFF87171), selectedTextColor: Color(0xFFFFFFFF)), AnswerOption(text: 'No', selectedBgColor: Color(0xFF2DD4BF), selectedTextColor: Color(0xFF000000))], factor: FactorType.pain),
            const SizedBox(height: 20),
            AppButton(
              "Log Sleep Here",
              width: 250,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SleepLogScreen(),
                  ),
                );
              }
            ),
            AppButton('Test', onTap: (){},),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                children: [
                  InfoTile(title: blockerTitle(result!), desc: blockerDescription(result), infoType: InfoType.blocker),
                  const SizedBox(height: 40,),
                  InfoTile(title: "Personalized Advice", desc: adviceText(result), infoType: InfoType.advice),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  
  }
} 
