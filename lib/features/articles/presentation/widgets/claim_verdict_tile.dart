import 'package:flutter/material.dart';

import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import 'article_verdict_visuals.dart';

/// One extracted claim with its NLI verdict, confidence and (expandable)
/// supporting evidence.
class ClaimVerdictTile extends StatelessWidget {
  const ClaimVerdictTile({super.key, required this.claim, required this.index});

  final ClaimVerdictResult claim;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = ArticleVerdictVisuals.claimColor(claim.verdict);
    final hasEvidence = (claim.evidence ?? '').trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        padding: EdgeInsets.zero,
        // The ExpansionTile header is a ListTile, which paints its ink on the
        // nearest Material — SoftCard's is transparent and sits behind the
        // card's opaque fill, so without this wrapper the splash is invisible
        // (and asserts in debug).
        child: Material(
          type: MaterialType.transparency,
          child: Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              leading: Icon(
                ArticleVerdictVisuals.claimIcon(claim.verdict),
                color: color,
              ),
              title: Text(
                'Claim ${index + 1}',
                style: theme.textTheme.labelMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(claim.claim, style: theme.textTheme.bodyMedium),
              ),
              children: [
                Row(
                  children: [
                    StatusBadge(
                      label: claim.verdict.label,
                      color: color,
                      dense: true,
                    ),
                    const SizedBox(width: 8),
                    if (claim.status == ClaimStatus.failed)
                      const StatusBadge(
                        label: 'Check failed',
                        color: Colors.grey,
                        dense: true,
                      )
                    else
                      Text(
                        '${(claim.confidence * 100).toStringAsFixed(0)}% confidence',
                        style: theme.textTheme.bodySmall,
                      ),
                  ],
                ),
                if (hasEvidence) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Evidence', style: theme.textTheme.labelSmall),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    claim.evidence!.trim(),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                if ((claim.sourceUrl ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      claim.sourceUrl!.trim(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
