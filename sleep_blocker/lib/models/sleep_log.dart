import 'package:uuid/uuid.dart';

const uuid = Uuid();
class SleepLog {
  final String id; 
  final DateTime date;
  final double duration; 
  final int qualityScore; 

  SleepLog({
    required this.date,
    required this.duration,
    required this.qualityScore,
  }) : id = uuid.v4();
}