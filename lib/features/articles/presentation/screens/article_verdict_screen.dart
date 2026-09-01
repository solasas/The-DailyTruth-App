import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart' show Share;

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../domain/entities/article.dart';
import '../../domain/entities/article_enums.dart';
import '../providers/articles_providers.dart';
import '../widgets/article_verdict_visuals.dart';
import '../widgets/claim_verdict_tile.dart';
import '../widgets/degradation_banner.dart';
import '../widgets/verification_progress.dart';

/// Live view of one verification job: polls `GET /articles/{id}` and renders
/// stage progress, then the aggregated verdict + per-claim breakdown.
class ArticleVerdictScreen extends ConsumerWidget {
  const ArticleVerdictScreen({super.key, required this.articleId});

  final String articleId;

  String _shareText(Article article) {
    final v = article.verdict;
    final buffer = StringBuffer('The Daily Truth — agentic verification\n');
    buffer.writeln('Verdict: ${v?.verdict.label ?? article.status.label}');
    if (v != null) {
      buffer.writeln('Confidence: ${(v.confidence * 100).toStringAsFixed(1)}%');
      buffer.writeln(
        'Claims checked: ${v.claims.length} '
        '(${v.supportedClaims} supported, ${v.contradictedClaims} contradicted)',
      );
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(articleStatusProvider(articleId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        actions: [
          if (async.valueOrNull?.isCompleted ?? false)
            IconButton(
              icon: const Icon(Icons.share_rounded),
              onPressed: () => Share.share(_shareText(async.value!)),
            ),
        ],
      ),
      body: async.when(
        loading: () => const _ProcessingView(stage: ArticleStage.queued),
        error: (error, _) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(articleStatusProvider(articleId)),
        ),
        data: (article) => switch (article.status) {
          ArticleStatus.processing => _ProcessingView(stage: article.stage),
          ArticleStatus.failed => ErrorView(
            error: article.error ?? 'Verification failed on the server.',
            onRetry: () => ref.invalidate(articleStatusProvider(articleId)),
          ),
          ArticleStatus.completed => _VerdictView(
            article: article,
            onCopy: () async {
              await Clipboard.setData(ClipboardData(text: _shareText(article)));
              if (context.mounted) {
                SnackbarUtils.showSuccess(context, 'Summary copied');
              }
            },
          ),
        },
      ),
    );
  }
}

class _ProcessingView extends StatelessWidget {
  const _ProcessingView({required this.stage});

  final ArticleStage stage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Working through the pipeline',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'This usually takes under a minute. You can leave this screen — the '
          'job keeps running on the server.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        VerificationProgress(stage: stage),
      ],
    );
  }
}

class _VerdictView extends StatelessWidget {
  const _VerdictView({required this.article, required this.onCopy});

  final Article article;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final verdict = article.verdict;

    if (verdict == null) {
      return const ErrorView(
        error: 'The job completed but returned no verdict.',
      );
    }

    final color = ArticleVerdictVisuals.color(verdict.verdict);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GradientCard(
          colors: [color, color.withValues(alpha: 0.75)],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    ArticleVerdictVisuals.icon(verdict.verdict),
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      verdict.verdict.label,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${(verdict.confidence * 100).toStringAsFixed(1)}% confidence · '
                '${verdict.claims.length} claims checked',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (verdict.isDegraded) ...[
          for (final d in verdict.degradations)
            DegradationBanner(degradation: d),
          const SizedBox(height: 8),
        ],
        if ((verdict.rationale ?? '').trim().isNotEmpty) ...[
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Why', style: theme.textTheme.labelMedium),
                const SizedBox(height: 6),
                Text(
                  verdict.rationale!.trim(),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Claims', style: theme.textTheme.titleMedium),
            Row(
              children: [
                StatusBadge(
                  label: '${verdict.supportedClaims} supported',
                  color: ArticleVerdictVisuals.claimColor(
                    ClaimVerdict.entailment,
                  ),
                  dense: true,
                ),
                const SizedBox(width: 6),
                StatusBadge(
                  label: '${verdict.contradictedClaims} against',
                  color: ArticleVerdictVisuals.claimColor(
                    ClaimVerdict.contradiction,
                  ),
                  dense: true,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (verdict.claims.isEmpty)
          Text(
            'No individual claims were extracted.',
            style: theme.textTheme.bodySmall,
          )
        else
          for (var i = 0; i < verdict.claims.length; i++)
            ClaimVerdictTile(claim: verdict.claims[i], index: i),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onCopy,
          icon: const Icon(Icons.copy_rounded),
          label: const Text('Copy summary'),
        ),
      ],
    );
  }
}
