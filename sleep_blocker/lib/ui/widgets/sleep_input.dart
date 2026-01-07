import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SleepInputWidget extends StatelessWidget {
  final double duration;
  final int? qualityScore;
  final Function(int) onQualitySelected;
  final Function(double) onDurationChanged;

  const SleepInputWidget({
    super.key,
    required this.duration,
    required this.qualityScore,
    required this.onQualitySelected,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    //quality
                    const Text("How was your sleep?", style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 15),
                    Row(
                      children: List.generate(5, (index) {
                        final score = index + 1;
                        return Expanded(
                          child: IconButton(
                            icon: Icon(
                              _emojiIcon(score),
                              size: 40,
                              color: qualityScore == score
                                  ? AppTheme.primaryColor
                                  : Colors.grey,
                            ),
                            onPressed: () => onQualitySelected(score),
                          ),
                        );
                      }),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: Colors.white10), 
                    ),

                    //duration
                    const Text("Sleep Duration", style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 20),
                    
                    Text(
                      "${duration.toStringAsFixed(1)} Hours",
                      style: TextStyle(
                        color: AppTheme.primaryColor, 
                        fontSize: 32, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0h", style: TextStyle(color: Colors.grey)),
                          Text("12h", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),

                    Slider(
                      value: duration,
                      min: 0,
                      max: 12,
                      divisions: 24,
                      activeColor: AppTheme.primaryColor,
                      inactiveColor: Colors.grey.withValues(),
                      onChanged: onDurationChanged
                    ),
                  ],
                ),
              ),
      ],
    );
  }
  // // Helper method for the emojis
  // Widget _buildEmoji(int score, IconData icon) {
  //   return IconButton(
  //     icon: Icon(icon, size: 40,
  //         color: qualityScore == score ? AppTheme.primaryColor : Colors.grey),
  //     onPressed: () => onQualitySelected(score)
  //   );
  // }

  IconData _emojiIcon(int score) {
    switch (score) {
      case 1: return Icons.sentiment_very_dissatisfied;
      case 2: return Icons.sentiment_dissatisfied;
      case 3: return Icons.sentiment_neutral;
      case 4: return Icons.sentiment_satisfied;
      case 5: return Icons.sentiment_very_satisfied;
      default: return Icons.sentiment_neutral;
    }
  }

}
  