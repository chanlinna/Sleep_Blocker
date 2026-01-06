import '../../logic/sleep_blocker_analyzer.dart';
import '../../models/factor_type.dart';

String blockerTitle(BlockerAnalysisResult result) {
  switch (result.status) {
    case BlockerStatus.notEnoughData:
      return "Not enough data";
    case BlockerStatus.noBlockerDetected:
      return "Sleep looks good";
    case BlockerStatus.success:
      return "Your biggest sleep blocker";
  }
}

String blockerDescription(BlockerAnalysisResult result) {
  switch (result.status) {
    case BlockerStatus.notEnoughData:
      return "Log at least 7 nights of sleep to discover your sleep blockers.";
    case BlockerStatus.noBlockerDetected:
      return "No strong sleep blockers were detected in the last 7 nights.";
    case BlockerStatus.success:
      return result.blocker!.factor.name;
  }
}

String adviceText(BlockerAnalysisResult result) {
  if (result.status != BlockerStatus.success) {
    return "Keep logging your sleep to receive personalized advice.";
  }

  switch (result.blocker!.factor.type) {
    case FactorType.screen:
      return "Try putting your phone away 30 minutes before bed.";
    case FactorType.pain:
      return "Consider light stretching or pain relief before sleep.";
    case FactorType.noise:
      return "Reduce noise or try earplugs before bed.";
    case FactorType.stress:
      return "Try breathing or relaxation exercises before sleep.";
  }
}

String insightText(BlockerAnalysisResult result) {
  if (result.status != BlockerStatus.success) {
    return "We'll show insights once enough sleep data is collected.";
  }

  final impact = result.blocker!.impact.abs().toStringAsFixed(1);
  final factor = result.blocker!.factor.name;

  return "$factor reduced your sleep quality by $impact points "
      "on average over the last 7 nights.";
}
