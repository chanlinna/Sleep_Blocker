import "./factor.dart";

class HabitLog {
  final String sleepLogId; 
  final FactorType factorType;
  final int value; // Binary: 0 (No) or 1 (Yes/Loud/High)

  HabitLog({
    required this.sleepLogId,
    required this.factorType,
    required this.value,
  });
}