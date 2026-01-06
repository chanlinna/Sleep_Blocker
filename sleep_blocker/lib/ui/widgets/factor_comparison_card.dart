import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class FactorComparisonCard extends StatelessWidget{
  const FactorComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}