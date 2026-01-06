import 'package:flutter/material.dart';
import '../../models/factor.dart';
import '../../models/factor_type.dart';
import '../../ui/theme/app_theme.dart';

class FactorTile extends StatelessWidget {
  final Factor factor;
  final int? selectedValue;
  final Function(int) onChanged;

  const FactorTile({
    super.key,
    required this.factor,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBinary = factor.type == FactorType.screen || factor.type == FactorType.pain;
    final List<String> options = isBinary ? ["Yes", "No"] : ["Low", "Medium", "High"];
    final String displayQuestion = (factor.rotatingQuestions..shuffle()).first;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(factor.type.icon, color: Colors.cyan),
                const SizedBox(width: 12),
                Text(factor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(displayQuestion, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            Row(
              children: List.generate(options.length, (index) {
                // Map "Yes" to 1, "No" to 0 for binary. Map 0, 1, 2 for scale.
                int valueToSave = isBinary ? (index == 0 ? 1 : 0) : index;
                bool isSelected = selectedValue == valueToSave;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: isSelected ? Colors.cyan : Colors.transparent,
                        side: BorderSide(color: isSelected ? Colors.cyan : Colors.white24),
                      ),
                      onPressed: () => onChanged(valueToSave),
                      child: Text(
                        options[index],
                        style: TextStyle(color: isSelected ? Colors.black : Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}