import 'package:flutter/material.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/widgets/app_button.dart';
import 'package:sleep_blocker/ui/widgets/question_tile.dart';
import 'package:sleep_blocker/ui/screens/sleep_log_screens/sleep_log.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
        ],
      ),
    );
  
  }
} 
