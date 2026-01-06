import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class ExpandCollapseButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const ExpandCollapseButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        isExpanded ? 'Hide factors' : 'View all factors',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
