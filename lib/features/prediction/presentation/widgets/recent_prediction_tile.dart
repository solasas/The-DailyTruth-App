import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/prediction_history_entry.dart';
import 'verdict_visuals.dart';

/// One row in the "Recent checks" feed (Home) and the History list — a
/// 60×60 thumbnail slot, a 2-line title, and a `model · time` meta line,
/// separated by a hairline divider.
class RecentPredictionTile extends StatelessWidget {
  const RecentPredictionTile({
    super.key,
    required this.entry,
    this.onTap,
    this.onDelete,
    this.showDivider = true,
  });

  final PredictionHistoryEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final label = entry.consensusLabel ?? entry.primaryResult.label;
    final confidence =
        entry.consensusConfidence ?? entry.primaryResult.confidence;
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: label.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(label.icon, color: label.color, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${entry.isAllModels ? "All models" : entry.primaryResult.displayName}'
                                  ' · ${(confidence * 100).toStringAsFixed(0)}%'
                                  ' · ${DateFormatter.relative(entry.timestamp)}'
                              .toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                            color: muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: onDelete,
                    ),
                ],
              ),
              if (showDivider) ...[
                const SizedBox(height: 12),
                Divider(height: 1, color: theme.dividerColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
