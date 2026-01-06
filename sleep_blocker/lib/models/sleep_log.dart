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

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(), 
    'duration': duration,
    'qualityScore': qualityScore,
  };

  factory SleepLog.fromJson(Map<String, dynamic> json) => SleepLog(
    id: json['id'],
    date: DateTime.parse(json['date']),
    duration: json['duration'],
    qualityScore: json['qualityScore'],
  );
}