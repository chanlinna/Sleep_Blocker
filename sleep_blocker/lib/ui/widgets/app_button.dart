import 'package:flutter/material.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    required this.onTap,
    this.width,
  });

  final String label;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: SizedBox(
            width: width ?? double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              label: Text(label, style: Theme.of(context).textTheme.headlineMedium),
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.white10, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text('Your data is saved offline', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 10),
      ],
    );
  }
}