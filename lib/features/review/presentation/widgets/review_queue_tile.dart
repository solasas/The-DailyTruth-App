import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/review_queue_item.dart';

class ReviewQueueTile extends StatelessWidget {
  const ReviewQueueTile({
    super.key,
    required this.item,
    required this.onResolve,
  });

  final ReviewQueueItem item;
  final VoidCallback onResolve;

  Color get _statusColor => switch (item.status) {
    ReviewStatus.pending => AppColors.warning,
    ReviewStatus.inReview => AppColors.primary,
    ReviewStatus.resolved => AppColors.success,
    ReviewStatus.escalated => AppColors.error,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatusBadge(
                  label: item.status.label,
                  color: _statusColor,
                  dense: true,
                ),
                const Spacer(),
                if (item.createdAt != null)
                  Text(
                    DateFormatter.relative(item.createdAt!),
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.textPreview.isEmpty ? '(no preview)' : item.textPreview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if ((item.modelVerdict ?? '').isNotEmpty)
                  StatusBadge(
                    label: 'Model: ${item.modelVerdict}',
                    color: AppColors.primary,
                    dense: true,
                    icon: Icons.smart_toy_outlined,
                  ),
                if (item.confidence != null)
                  Text(
                    '${(item.confidence! * 100).toStringAsFixed(0)}% conf.',
                    style: theme.textTheme.bodySmall,
                  ),
                if ((item.reason ?? '').isNotEmpty)
                  Text('· ${item.reason}', style: theme.textTheme.bodySmall),
              ],
            ),
            if (item.status.isOpen) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: onResolve,
                  icon: const Icon(Icons.gavel_rounded, size: 18),
                  label: const Text('Resolve'),
                ),
              ),
            ] else if ((item.resolutionNote ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Resolution: ${item.resolutionNote}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
