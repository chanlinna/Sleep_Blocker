import 'package:flutter/material.dart';
import '../../../models/sleep_log.dart';
import '../../../models/habit_log.dart';
import '../../../ui/widgets/app_button.dart';
import '../../../data/mock_factor.dart';
import '../../widgets/factor_tile.dart';

class HabitLogScreen extends StatefulWidget {
  final SleepLog sleepRecord; 

  const HabitLogScreen({super.key, required this.sleepRecord});

  @override
  State<HabitLogScreen> createState() => _HabitLogScreenState();
}

class _HabitLogScreenState extends State<HabitLogScreen> {
  // Map to track selections: { 'F1': 1, 'F3': 0 }
  final Map<String, int> _selections = {};

  void _onSave() {
    // Transform the Map into a List of HabitLog objects
    final List<HabitLog> habitsToSave = _selections.entries.map((entry) {
      return HabitLog(
        sleepLogId: widget.sleepRecord.id, // Assuming SleepLog has an ID
        factorId: entry.key,
        value: entry.value,
      );
    }).toList();

    // Proceed to your Service/Repository to save habitsToSave
    print("Saving ${habitsToSave.length} habits for this night.");
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Night Factors")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mockFactors.length,
              itemBuilder: (context, index) {
                final factor = mockFactors[index];
                return FactorTile(
                  factor: factor,
                  selectedValue: _selections[factor.factorId],
                  onChanged: (val) {
                    setState(() => _selections[factor.factorId] = val);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              "Finish Log",
              onTap: _selections.length < mockFactors.length ? null : _onSave,
            ),
          ),
        ],
      ),
    );
  }
}