import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'app_button.dart';

class SuccessWidget extends StatelessWidget {

  final VoidCallback onReLog;
  const SuccessWidget({super.key, required this.onReLog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppTheme.darkTheme.cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Sleep is already logged. Have a great day!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.wb_sunny_outlined, color: Colors.cyan, size: 80),
              ],
            ),
          ),
          const SizedBox(height: 40),
          AppButton(
            "Re-log Sleep",
            onTap: onReLog,
          ),
        ],
      ),
    );
  }
}