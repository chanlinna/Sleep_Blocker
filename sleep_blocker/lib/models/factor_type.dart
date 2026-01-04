import 'package:flutter/material.dart';

enum FactorType { 
  screen(Icons.phone_android),
  pain(Icons.health_and_safety),
  noise(Icons.volume_up),
  stress(Icons.mood_bad);

  final IconData icon;

  const FactorType(this.icon);
  
}