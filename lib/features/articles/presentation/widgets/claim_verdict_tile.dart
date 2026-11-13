import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import '../../domain/entities/origin.dart';
import 'article_verdict_visuals.dart';
import 'origin_trail_view.dart';

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
    final snippets = claim.evidenceSnippets.isNotEmpty
        ? claim.evidenceSnippets
        : [if ((claim.evidence ?? '').trim().isNotEmpty) claim.evidence!.trim()];

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
                if (claim.verdict == ClaimVerdict.unverifiable) ...[
                  const SizedBox(height: 8),
                  Text(
                    'That is not evidence against it — recent, regional and '
                    'non-English topics are often missed.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                if (snippets.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Evidence', style: theme.textTheme.labelSmall),
                  ),
                  const SizedBox(height: 4),
                  for (var i = 0; i < snippets.length; i++)
                    _EvidenceItem(
                      snippet: snippets[i],
                      domain: i < claim.sources.length ? claim.sources[i] : '',
                      meta: i < claim.evidenceMeta.length
                          ? claim.evidenceMeta[i]
                          : null,
                      fallbackUrl: i == 0 ? claim.sourceUrl : null,
                    ),
                ],
                if (claim.origin != null) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OriginTrailView(origin: claim.origin!),
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

class _EvidenceItem extends StatelessWidget {
  const _EvidenceItem({
    required this.snippet,
    required this.domain,
    required this.meta,
    required this.fallbackUrl,
  });

  final String snippet;
  final String domain;
  final EvidenceMeta? meta;
  final String? fallbackUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = (meta?.domain ?? '').isNotEmpty ? meta!.domain : domain;
    final url = (meta?.url ?? '').isNotEmpty ? meta!.url : (fallbackUrl ?? '');
    final stance = meta?.stance ?? 'neutral';
    final (stanceLabel, stanceColor) = switch (stance) {
      'repeats' => ('repeats claim', AppColors.accent500),
      'debunks' => ('contradicts claim', AppColors.sage500),
      _ => ('neutral', AppColors.neutral600),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(snippet.trim(), style: theme.textTheme.bodySmall),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (name.isNotEmpty)
                InkWell(
                  onTap: url.isEmpty
                      ? null
                      : () {
                          final uri = Uri.tryParse(url);
                          if (uri != null) {
                            launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                  child: Text(
                    name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: url.isEmpty ? null : theme.colorScheme.primary,
                      decoration:
                          url.isEmpty ? null : TextDecoration.underline,
                    ),
                  ),
                ),
              if (meta != null)
                StatusBadge(label: stanceLabel, color: stanceColor, dense: true),
              if (meta != null)
                Text(
                  'trust ${meta!.trust.toStringAsFixed(2)}',
                  style: theme.textTheme.labelSmall,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
