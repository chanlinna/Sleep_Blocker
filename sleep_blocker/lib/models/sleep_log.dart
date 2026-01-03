class SleepLog {
  final String userId;
  final String id; 
  final DateTime date;
  final double duration; 
  final int qualityScore; 

  SleepLog({
    required this.userId,
    required this.id,
    required this.date,
    required this.duration,
    required this.qualityScore,
  });
}