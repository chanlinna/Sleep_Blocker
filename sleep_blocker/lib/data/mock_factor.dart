import 'package:sleep_blocker/models/factor.dart';
import 'package:sleep_blocker/models/factor_type.dart';

final List<Factor> mockFactors = [
  Factor(
    factorId: 'F1',
    type: FactorType.screen,
    name: "Screen Time",
    rotatingQuestions: [
      "Did you use your phone in bed?",
      "Were you scrolling before sleeping?",
      "Did you watch videos in bed?",
    ],
  ),
  Factor(
    factorId: 'F2',
    type: FactorType.pain,
    name: "Pain / Discomfort",
    rotatingQuestions: [
      "Did you feel physical pain at night?",
      "Was body discomfort bothering you?",
      "Did muscle pain affect your sleep?",
    ],
  ),
  Factor(
    factorId: 'F3',
    type: FactorType.noise,
    name: "Ambient Noise",
    rotatingQuestions: [
      "How noisy was your environment?",
      "Did sound disturb your sleep?",
      "Was your room loud?",
    ],
  ),
  Factor(
    factorId: 'F4',
    type: FactorType.stress,
    name: "Stress / Anxiety",
    rotatingQuestions: [
      "How stressed did you feel before sleep?",
      "Were you anxious at night?",
      "Did worry affect your sleep?",
    ],
  ),
];
