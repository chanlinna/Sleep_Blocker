import 'package:flutter/material.dart';
import 'package:sleep_blocker/logic/calculate_sleep_health.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class SleepHealth extends StatelessWidget {
  final double avgDurationHours;
  final double avgQuality;

  const SleepHealth({
    super.key,
    required this.avgDurationHours,
    required this.avgQuality,
  });


  @override
  Widget build(BuildContext context) {
    final healthIndex = SleepHealthCalculator().sleepHealthIndex(
      avgDurationHours: avgDurationHours,
      avgQuality: avgQuality,
    ); 

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Poor',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.highRiskColor),
              ),
              Text(
                'Great',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.primaryColor),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: List.generate(5, (index) {
              final isActive = index + 1 == healthIndex;
              final isFilled = index < healthIndex;

              return Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Icon(
                          _iconForIndex(index),
                          size: isActive ? 36 : 24,
                          color: isActive
                              ? AppTheme.primaryColor
                              : Color(0xFFA8A3A3),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isFilled
                            ? AppTheme.primaryColor
                            : AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  IconData _iconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.sentiment_very_dissatisfied;
      case 1:
        return Icons.sentiment_dissatisfied;
      case 2:
        return Icons.sentiment_neutral;
      case 3:
        return Icons.sentiment_satisfied;
      default:
        return Icons.sentiment_very_satisfied;
    }
  }
}
