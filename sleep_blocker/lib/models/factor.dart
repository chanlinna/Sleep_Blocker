import 'package:sleep_blocker/models/factor_type.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Factor {
  final String factorId;
  final FactorType type;
  final String name;
  final List<String> rotatingQuestions; 

  Factor({
    required this.type,
    required this.name,
    required this.rotatingQuestions,
  }): factorId = uuid.v4();
}