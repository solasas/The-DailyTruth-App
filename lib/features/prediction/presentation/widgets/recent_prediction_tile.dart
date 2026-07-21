import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/prediction_history_entry.dart';
import 'verdict_visuals.dart';

/// One row in the Recent Predictions list (Home + History screens).
class RecentPredictionTile extends StatelessWidget {
  const RecentPredictionTile({
    super.key,
    required this.entry,
    this.onTap,
    this.onDelete,
  });

  final PredictionHistoryEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final label = entry.consensusLabel ?? entry.primaryResult.label;
    final confidence = entry.consensusConfidence ?? entry.primaryResult.confidence;
    final theme = Theme.of(context);

    final tile = ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      leading: CircleAvatar(
        backgroundColor: label.color.withValues(alpha: 0.12),
        child: Icon(label.icon, color: label.color, size: 20),
      ),
      title: Text(
        entry.text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${entry.isAllModels ? "All models" : entry.primaryResult.modelName} · '
        '${(confidence * 100).toStringAsFixed(0)}% · ${DateFormatter.relative(entry.timestamp)}',
        style: theme.textTheme.bodySmall,
      ),
      trailing: onDelete != null
          ? IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: onDelete,
            )
          : Icon(Icons.chevron_right_rounded, color: theme.dividerColor),
    );

    return Padding(padding: const EdgeInsets.only(bottom: 8), child: tile);
  }
}
