import 'package:flutter/material.dart';
import 'package:sleep_blocker/models/factor_type.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class FactorIconsRow extends StatelessWidget {
  final List<FactorType> factors;

  const FactorIconsRow({super.key, required this.factors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: factors.map((factor) {
        return Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            factor.icon,
            size: 18,
            color: AppTheme.highRiskColor,
          ),
        );
      }).toList(),
    );
  }
}
