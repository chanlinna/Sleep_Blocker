import '../../logic/sleep_blocker_analyzer.dart';
import '../../models/factor_type.dart';

BlockerResult? _primary(BlockerAnalysisResult result) {
  if (result.blockers.isEmpty) return null;
  return result.blockers.first;
}

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
      final blocker = _primary(result);
      return blocker!.factor.name;
  }
}

String adviceText(BlockerAnalysisResult result) {
  final blocker = _primary(result);

  if (blocker == null) {
    return "Keep logging your sleep to receive personalized advice.";
  }

  switch (blocker.factor.type) {
    case FactorType.screen:
      return "Try putting your phone away 30 minutes before bed or switch to night mode.";
    case FactorType.pain:
      return "Gentle stretching, a warm shower, or pain relief may help you sleep more comfortably.";
    case FactorType.noise:
      return "Lower background noise, close windows, or try earplugs or white noise.";
    case FactorType.stress:
      return "Slow breathing, meditation, or writing down worries can help calm your mind.";
  }
}

String insightText(BlockerAnalysisResult result) {
  final blocker = _primary(result);
  if (blocker == null) {
    return "We'll show insights once enough sleep data is collected.";
  }

  final impact = blocker.impact.abs().toStringAsFixed(1);
  final factor = blocker.factor.name;

  return "$factor reduced your sleep quality by $impact points "
      "on average over the last 7 nights.";
}
