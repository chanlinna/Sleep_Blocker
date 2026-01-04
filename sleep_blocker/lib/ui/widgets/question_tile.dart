import 'package:flutter/material.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class QuestionTile extends StatefulWidget {
  final String question;
  final List<AnswerOption> options;
  final FactorType factor; 
  final Function(int selectedIndex)? onAnswerSelected;

  const QuestionTile({
    super.key,
    required this.question,
    required this.options,
    required this.factor,
    this.onAnswerSelected,
  });

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(widget.factor.icon, color: Color(0xFFF87171)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(widget.options.length, (index) {
                    final option = widget.options[index];
                    final isSelected = _selectedIndex == index;
      
                    final background = isSelected ? option.selectedBgColor : const Color(0xFF334155);
                    final textColor = isSelected ? option.selectedTextColor : Colors.white;
      
                    return ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedIndex = index);
                        if (widget.onAnswerSelected != null) widget.onAnswerSelected!(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: background,
                        foregroundColor: textColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      child: Text(option.text),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerOption {
  final String text;
  final Color selectedBgColor;
  final Color selectedTextColor;

  AnswerOption({
    required this.text,
    required this.selectedBgColor,
    required this.selectedTextColor,
  });
}
