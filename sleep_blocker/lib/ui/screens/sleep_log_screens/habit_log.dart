import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../../models/sleep_log.dart';
import '../../../models/habit_log.dart';
import '../../../ui/widgets/app_button.dart';
import '../../../data/mock_factor.dart';
import '../../widgets/factor_tile.dart';
import '../../../logic/log_service.dart';

class HabitLogScreen extends StatefulWidget {
  final SleepLog sleepRecord; 

  const HabitLogScreen({super.key, required this.sleepRecord});

  @override
  State<HabitLogScreen> createState() => _HabitLogScreenState();
}

class _HabitLogScreenState extends State<HabitLogScreen> {
  final Map<String, int> _selections = {};
  final Map<String, String> _chosenQuestions = {};

  @override
  void initState() {
    super.initState();
    for (var factor in mockFactors) {
      final List<String> questions = List.from(factor.rotatingQuestions);
      questions.shuffle();
      _chosenQuestions[factor.factorId] = questions.first;
    }
  }

  void _onSave() {
    final List<HabitLog> habitsToSave = _selections.entries.map((entry) {
      return HabitLog(
        sleepLogId: widget.sleepRecord.id,
        factorId: entry.key,
        value: entry.value,
      );
    }).toList();

    LogService.saveFullNight(widget.sleepRecord, habitsToSave);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Sleep Log"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text(
                      "What might have affected your sleep",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...mockFactors.map((factor) => FactorTile(
                    factor: factor,
                    displayQuestion: _chosenQuestions[factor.factorId] ?? factor.name,
                    selectedValue: _selections[factor.factorId],
                    onChanged: (val) => setState(() => _selections[factor.factorId] = val),
                  )),
                  AppButton(
                    "Save",
                    onTap: _selections.length < mockFactors.length ? null : _onSave,
                  ),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}