import 'package:flutter/material.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

enum ComparisonStyle { binary, ordinal }

ComparisonStyle comparisonStyleFor(FactorType type) {
  switch (type) {
    case FactorType.screen:
    case FactorType.pain:
      return ComparisonStyle.binary;
    case FactorType.noise:
    case FactorType.stress:
      return ComparisonStyle.ordinal;
  }
}

/// FactorComparisonCard
/// Shows avg quality for each factor level, visual bar, and impact
class FactorComparisonCard extends StatelessWidget {
  final BlockerResult result;

  const FactorComparisonCard({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final factor = result.factor;
    final style = comparisonStyleFor(factor.type);

    // Compute averages for display
    final averages = _computeAverages(result, style);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(factor.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),

          // Display levels
          for (final level in averages.keys)
            _buildLevelBar(context, level, averages[level]!),

          const SizedBox(height: 10),
          Text(
            "Impact −${result.impact.abs().toStringAsFixed(1)}",
            style: const TextStyle(color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  /// Builds a horizontal bar for each factor level
  Widget _buildLevelBar(BuildContext context, String label, double avgQuality) {
    final barColor = avgQuality <= 2.5
        ? Colors.redAccent
        : avgQuality <= 4.0
            ? Colors.orangeAccent
            : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(label)),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: avgQuality / 5, // max quality = 5
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(avgQuality.toStringAsFixed(1)),
        ],
      ),
    );
  }

  /// Compute averages per factor level
  Map<String, double> _computeAverages(BlockerResult result, ComparisonStyle style) {
    final averages = <String, double>{};

    switch (style) {
      case ComparisonStyle.binary:
        // Yes / No averages
        averages['Yes'] = result.yesAvg;
        averages['No'] = result.noAvg;
        break;
      case ComparisonStyle.ordinal:
        // High / Medium / Low averages
        averages['Low'] = result.lowAvg;
        averages['Medium'] = result.mediumAvg;
        averages['High'] = result.highAvg;
        break;
    }

    return averages;
  }
}
