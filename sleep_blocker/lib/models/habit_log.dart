class HabitLog {
  final String sleepLogId; 
  final String factorId;
  final int value; 

  HabitLog({
    required this.sleepLogId,
    required this.factorId,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
    'sleepLogId': sleepLogId,
    'factorId': factorId,
    'value': value,
  };

  factory HabitLog.fromJson(Map<String, dynamic> json) => HabitLog(
    sleepLogId: json['sleepLogId'], factorId: json['factorId'], value: json['value']
  );
}