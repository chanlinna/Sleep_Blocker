import 'package:flutter/material.dart';
import '../../models/factor.dart';
import '../../models/factor_type.dart';
import '../../ui/theme/app_theme.dart';

class FactorTile extends StatelessWidget {
  final Factor factor;
  final String displayQuestion;
  final int? selectedValue;
  final Function(int) onChanged;

  const FactorTile({
    super.key,
    required this.factor,
    required this.displayQuestion,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isBinary = factor.type == FactorType.screen || factor.type == FactorType.pain;
    final List<String> options = isBinary ? ["Yes", "No"] : ["Low", "Medium", "High"];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(factor.type.icon, color: const Color(0xFFF87171), size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  displayQuestion,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(options.length, (index) {
              int valueToSave = isBinary ? (index == 0 ? 1 : 0) : index;
              bool isSelected = selectedValue == valueToSave;

              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected 
                          ? AppTheme.primaryColor 
                          : const Color(0xFF334155), 
                      foregroundColor: isSelected ? Colors.black : Colors.white70,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () => onChanged(valueToSave),
                    child: Text(options[index]),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}