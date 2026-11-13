import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/origin.dart';
import 'propagation_graph.dart';

/// Per-claim origin trail: who made the claim, how it spread over time, and
/// every source found — oldest first.
///
/// It only sees what search engines index (messaging apps and most social
/// posts are not), so the caveat is always shown.
class OriginTrailView extends StatelessWidget {
  const OriginTrailView({super.key, required this.origin});

  final Origin origin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final earliestUrl = origin.earliestSeen?.url;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline_rounded, size: 18, color: AppColors.primary),
            const SizedBox(width: 6),
            Text('Origin trail', style: theme.textTheme.titleSmall),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          'Earliest source found, not proof of origin.',
          style: theme.textTheme.bodySmall,
        ),
        if (origin.hasClaimant) ...[
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                const TextSpan(text: 'Claimed by '),
                TextSpan(
                  text: origin.claimant!.trim(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                if ((origin.claimDate ?? '').isNotEmpty)
                  TextSpan(text: ' on ${origin.claimDate}'),
                if ((origin.claimantSource ?? '').isNotEmpty)
                  TextSpan(text: ' · per ${origin.claimantSource} fact-check'),
              ],
            ),
          ),
        ],
        if (PropagationGraph.canDraw(origin)) ...[
          const SizedBox(height: 12),
          PropagationGraph(origin: origin),
        ],
        const SizedBox(height: 12),
        if (origin.timeline.isEmpty)
          Text(
            'No source found repeating or checking this claim.',
            style: theme.textTheme.bodySmall,
          )
        else
          for (final e in origin.timeline)
            _TimelineRow(entry: e, isEarliest: e.url == earliestUrl),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.entry, required this.isEarliest});

  final TimelineEntry entry;
  final bool isEarliest;

  (String, Color) _stance() {
    switch (entry.kind) {
      case 'repeats':
        return ('repeats claim', AppColors.accent500);
      case 'debunks':
        return ('contradicts claim', AppColors.sage500);
      case 'fact_check':
        final label = entry.label.isEmpty ? 'reviewed' : entry.label;
        final isTrue = label.toLowerCase().contains('true') &&
            !label.toLowerCase().contains('false') &&
            !label.toLowerCase().contains('not');
        return (
          'fact-check: $label',
          isTrue ? AppColors.neutral600 : AppColors.sage500,
        );
      default:
        return ('mentions claim', AppColors.neutral600);
    }
  }

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(entry.url);
    if (uri == null || entry.url.isEmpty) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (stanceLabel, stanceColor) = _stance();

    return InkWell(
      onTap: entry.url.isEmpty ? null : () => _open(context),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 82,
              child: Text(
                entry.isDated ? entry.date : 'undated',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.domain.isEmpty ? 'Unknown source' : entry.domain,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: entry.url.isEmpty
                          ? null
                          : theme.colorScheme.primary,
                      decoration: entry.url.isEmpty
                          ? null
                          : TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      StatusBadge(
                        label: stanceLabel,
                        color: stanceColor,
                        dense: true,
                      ),
                      if (entry.isWiderSearch)
                        const StatusBadge(
                          label: 'wider search',
                          color: AppColors.neutral600,
                          dense: true,
                        ),
                      if (isEarliest)
                        const StatusBadge(
                          label: 'earliest found',
                          color: AppColors.accent700,
                          dense: true,
                        ),
                      Text(
                        'trust ${entry.trust.toStringAsFixed(2)}',
                        style: theme.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
