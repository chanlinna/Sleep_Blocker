import 'package:flutter/material.dart';
import 'package:sleep_blocker/data/mock_factor.dart';
import 'package:sleep_blocker/logic/log_service.dart';
import 'package:sleep_blocker/logic/sleep_blocker_analyzer.dart';
import 'package:sleep_blocker/ui/helpers/blocker_text.dart';
import 'package:sleep_blocker/ui/theme/app_theme.dart';
import 'package:sleep_blocker/ui/widgets/expand_collapse_button.dart';
import 'package:sleep_blocker/ui/widgets/factor_comparison_card.dart';
import 'package:sleep_blocker/ui/widgets/info_tile.dart';
import 'package:sleep_blocker/ui/widgets/section_title.dart';
import 'package:sleep_blocker/ui/widgets/sleep_history_item.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  bool _showAllFactors = false;

  void onViewAllFactors() {
    setState(() {
      _showAllFactors = !_showAllFactors;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sleepLogs = LogService.sleepHistory;
    final habitLogs = LogService.habitHistory;

    final result = SleepBlockerAnalyzer.analyze(
      sleepLogs: sleepLogs,
      habitLogs: habitLogs,
      factors: mockFactors
    );

    final allBlockers = result.blockers;
    final visibleBlockers = _showAllFactors ? allBlockers : allBlockers.take(2).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insight'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.surfaceColor
              ),
              child: InfoTile(title: "Key Insights", desc: insightText(result), infoType: InfoType.insight)
            ),
            const SizedBox(height: 20,),
            SectionTitle(title: 'Factor Comparisons'),
            if (result.status == BlockerStatus.success && visibleBlockers.isNotEmpty)
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: visibleBlockers.map((blocker) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 150,
                            maxWidth: 180, 
                          ),
                          child: FactorComparisonCard(result: blocker),
                        );
                      }).toList(),
                    );

                  },
                ),
              ),
            if (allBlockers.length > 2)
              ExpandCollapseButton(isExpanded: _showAllFactors, onTap: onViewAllFactors,),
        
            const SizedBox(height: 20),
            SectionTitle(title: 'Sleep History'),
            Expanded(
                child: sleepLogs.isEmpty?
                Center(
                  child: Text(
                    "No sleep history yet.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
                :ListView.builder(
                  itemCount: sleepLogs.length,
                  itemBuilder: (context, index) {
                    final sleepLog = sleepLogs[sleepLogs.length - 1 - index];
                
                    final habitLogsForNight = habitLogs
                        .where((h) => h.sleepLogId == sleepLog.id)
                        .toList();
                
                    return SleepHistoryItem(
                      sleepLog: sleepLog,
                      habitLogs: habitLogsForNight,
                      factors: mockFactors,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  
  }
} 
