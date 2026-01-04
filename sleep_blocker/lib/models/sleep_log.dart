import 'package:uuid/uuid.dart';

const uuid = Uuid();
class SleepLog {
  final String id; 
  final DateTime date;
  final double duration; 
  final int qualityScore; 

  SleepLog({
    String? id,
    required this.date,
    required this.duration,
    required this.qualityScore,
  }) : id = id ?? uuid.v4();
}