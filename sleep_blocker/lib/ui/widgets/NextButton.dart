import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const NextButton({
    super.key,
    required this.onPressed,
    this.label = "Next",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBackgroundColor: Colors.white10,
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}