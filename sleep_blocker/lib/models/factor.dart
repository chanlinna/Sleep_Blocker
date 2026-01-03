enum FactorType { screen, pain, noise, stress }

class Factor {
  final FactorType type;
  final String name;
  final List<String> rotatingQuestions; 

  Factor({
    required this.type,
    required this.name,
    required this.rotatingQuestions,
  });
}