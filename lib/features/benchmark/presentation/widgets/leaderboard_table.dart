import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/benchmark_result.dart';
import '../providers/benchmark_providers.dart';

/// Horizontally scrollable, sortable leaderboard table. Column taps flip the
/// sort via [leaderboardSortProvider]; rank badges animate in with the rest
/// of the row through [AnimatedSwitcher] on data changes.
class LeaderboardTable extends StatelessWidget {
  const LeaderboardTable({
    super.key,
    required this.results,
    required this.sortState,
    required this.onSort,
  });

  final List<BenchmarkResult> results;
  final LeaderboardSortState sortState;
  final void Function(LeaderboardColumn column) onSort;

  int _columnIndex(LeaderboardColumn column) => LeaderboardColumn.values.indexOf(column);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DataTable(
        sortColumnIndex: _columnIndex(sortState.column),
        sortAscending: sortState.ascending,
        headingRowColor: WidgetStatePropertyAll(theme.colorScheme.primary.withValues(alpha: 0.06)),
        columns: [
          DataColumn(
            label: const Text('Rank'),
            onSort: (_, __) => onSort(LeaderboardColumn.rank),
          ),
          const DataColumn(label: Text('Model')),
          DataColumn(
            label: const Text('Accuracy'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.accuracy),
          ),
          DataColumn(
            label: const Text('F1'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.f1),
          ),
          DataColumn(
            label: const Text('Precision'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.precision),
          ),
          DataColumn(
            label: const Text('Recall'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.recall),
          ),
          DataColumn(
            label: const Text('AUC'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.auc),
          ),
          DataColumn(
            label: const Text('Train Time'),
            numeric: true,
            onSort: (_, __) => onSort(LeaderboardColumn.trainingTime),
          ),
        ],
        rows: results.map((result) {
          final isTop = result.rank == 1;
          return DataRow(
            color: isTop
                ? WidgetStatePropertyAll(AppColors.warning.withValues(alpha: 0.08))
                : null,
            cells: [
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isTop) const Icon(Icons.emoji_events_rounded, size: 16, color: AppColors.warning),
                    if (isTop) const SizedBox(width: 4),
                    Text('#${result.rank}'),
                  ],
                ),
              ),
              DataCell(Text(result.modelName, overflow: TextOverflow.ellipsis)),
              DataCell(Text('${(result.accuracy * 100).toStringAsFixed(1)}%')),
              DataCell(Text('${(result.f1Score * 100).toStringAsFixed(1)}%')),
              DataCell(Text('${(result.precision * 100).toStringAsFixed(1)}%')),
              DataCell(Text('${(result.recall * 100).toStringAsFixed(1)}%')),
              DataCell(Text('${(result.auc * 100).toStringAsFixed(1)}%')),
              DataCell(Text('${result.trainingTimeSeconds.toStringAsFixed(1)}s')),
            ],
          );
        }).toList(),
      ),
    );
  }
}
