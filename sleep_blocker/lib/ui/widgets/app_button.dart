import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    //required this.onTap,
  });

  final String label;
  //final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        label: Text(label, style: Theme.of(context).textTheme.headlineMedium),
        onPressed: (){},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 50,
          ),
        ));
  }
}