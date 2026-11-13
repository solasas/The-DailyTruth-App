import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/brand_app_bar.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/page_hero.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../models/presentation/providers/models_providers.dart';
import '../providers/prediction_providers.dart';

/// Compose a check: pick a mode (Single / Consensus / Batch) from the tab
/// strip, paste text, choose a model, tune the decision threshold, submit.
class AnalyzeScreen extends ConsumerStatefulWidget {
  const AnalyzeScreen({super.key});

  @override
  ConsumerState<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends ConsumerState<AnalyzeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> get _batchItems => _controller.text
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList();

  bool _isValid(CheckMode mode) {
    if (mode == CheckMode.batch) {
      final n = _batchItems.length;
      return n >= AppConstants.minBatchItems && n <= AppConstants.maxBatchItems;
    }
    final len = _controller.text.trim().length;
    return len >= AppConstants.minPredictTextLength &&
        len <= AppConstants.maxPredictTextLength;
  }

  Future<void> _run() async {
    final mode = ref.read(checkModeProvider);
    final threshold = ref.read(thresholdProvider);
    final model = ref.read(selectedModelProvider);

    if (mode.needsModel && model == null) {
      SnackbarUtils.showInfo(context, 'Pick a model first.');
      return;
    }

    switch (mode) {
      case CheckMode.single:
        await ref
            .read(singlePredictionProvider.notifier)
            .analyze(
              text: _controller.text.trim(),
              modelName: model!,
              threshold: threshold,
            );
        if (!mounted) return;
        ref
            .read(singlePredictionProvider)
            .whenOrNull(
              data: (r) => r != null ? context.push('/analyze/result') : null,
              error: (e, _) => SnackbarUtils.showError(context, e.toString()),
            );
      case CheckMode.consensus:
        await ref
            .read(allModelsPredictionProvider.notifier)
            .analyzeAll(text: _controller.text.trim(), threshold: threshold);
        if (!mounted) return;
        ref
            .read(allModelsPredictionProvider)
            .whenOrNull(
              data: (r) =>
                  r != null ? context.push('/analyze/result-all') : null,
              error: (e, _) => SnackbarUtils.showError(context, e.toString()),
            );
      case CheckMode.batch:
        await ref
            .read(batchPredictionProvider.notifier)
            .run(texts: _batchItems, modelName: model!, threshold: threshold);
        if (!mounted) return;
        ref
            .read(batchPredictionProvider)
            .whenOrNull(
              data: (r) =>
                  r != null ? context.push('/analyze/result-batch') : null,
              error: (e, _) => SnackbarUtils.showError(context, e.toString()),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary =
        theme.extension<AppSemanticColors>()?.textSecondary ??
        theme.colorScheme.onSurface;
    final mode = ref.watch(checkModeProvider);
    final threshold = ref.watch(thresholdProvider);
    final selectedModel = ref.watch(selectedModelProvider);
    final loadedModelsAsync = ref.watch(loadedModelsProvider);

    final busy =
        ref.watch(singlePredictionProvider).isLoading ||
        ref.watch(allModelsPredictionProvider).isLoading ||
        ref.watch(batchPredictionProvider).isLoading;

    // Rebuild validity when text changes.
    ref.watch(analyzeTextProvider);
    final valid = _isValid(mode);
    final count = mode == CheckMode.batch
        ? '${_batchItems.length} / ${AppConstants.maxBatchItems} items'
        : '${_controller.text.trim().length} / ${AppConstants.maxPredictTextLength}';

    return Scaffold(
      appBar: const BrandAppBar(),
      body: SafeArea(
        child: busy
            ? const _RunningState()
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PillTabs<CheckMode>(
                      values: CheckMode.values,
                      selected: mode,
                      labelOf: (m) => m.label,
                      onSelected: (m) =>
                          ref.read(checkModeProvider.notifier).state = m,
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 28),
                    PageHero(
                      badgeIcon: mode.badgeIcon,
                      badgeLabel: mode.badge,
                      title: mode.title,
                      subtitle: mode.subtitle,
                    ),
                    const SizedBox(height: 28),
                    AccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _controller,
                            minLines: 8,
                            maxLines: 14,
                            maxLength: mode == CheckMode.batch
                                ? null
                                : AppConstants.maxPredictTextLength,
                            onChanged: (v) =>
                                ref.read(analyzeTextProvider.notifier).state =
                                    v,
                            decoration: InputDecoration(
                              hintText: mode == CheckMode.batch
                                  ? 'Article 1\nArticle 2\nArticle 3'
                                  : 'Paste article content…',
                              alignLabelWithHint: true,
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  mode == CheckMode.batch
                                      ? 'One item per line · '
                                            '${AppConstants.minBatchItems}–'
                                            '${AppConstants.maxBatchItems} items'
                                      : '',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: secondary,
                                  ),
                                ),
                              ),
                              Text(
                                count,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: secondary,
                                ),
                              ),
                            ],
                          ),
                          if (mode.needsModel) ...[
                            const SizedBox(height: 18),
                            Text(
                              'MODEL',
                              style: AppTypography.eyebrow(secondary),
                            ),
                            const SizedBox(height: 8),
                            loadedModelsAsync.when(
                              loading: () => const LinearProgressIndicator(),
                              error: (e, _) => Text(
                                'Could not load models: $e',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                              data: (models) {
                                if (models.isEmpty) {
                                  return Text(
                                    'No models are loaded on the server.',
                                    style: theme.textTheme.bodySmall,
                                  );
                                }
                                return SizedBox(
                                  height: 44,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: models.length,
                                    separatorBuilder: (_, _) =>
                                        const SizedBox(width: 8),
                                    itemBuilder: (context, i) {
                                      final m = models[i];
                                      return Center(
                                        child: ChoiceChip(
                                          label: Text(m.displayName),
                                          showCheckmark: false,
                                          selected: selectedModel == m.name,
                                          onSelected: (_) =>
                                              ref
                                                      .read(
                                                        selectedModelProvider
                                                            .notifier,
                                                      )
                                                      .state =
                                                  m.name,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'THRESHOLD',
                                style: AppTypography.eyebrow(secondary),
                              ),
                              Text(
                                threshold.toStringAsFixed(2),
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                            value: threshold,
                            onChanged: (v) =>
                                ref.read(thresholdProvider.notifier).state = v,
                          ),
                          const SizedBox(height: 8),
                          // Red glow under the enabled button, as in the
                          // reference's "VERIFY ARTICLE" bar.
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: valid
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.35,
                                        ),
                                        blurRadius: 18,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: FilledButton(
                              onPressed: valid ? _run : null,
                              child: Text(mode.action.toUpperCase()),
                            ),
                          ),
                          if (_controller.text.isNotEmpty && !valid)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                mode == CheckMode.batch
                                    ? 'Enter ${AppConstants.minBatchItems}–'
                                          '${AppConstants.maxBatchItems} non-empty lines.'
                                    : 'Enter ${AppConstants.minPredictTextLength}–'
                                          '${AppConstants.maxPredictTextLength} characters.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

/// Reference copy for each mode's hero and submit button.
extension _CheckModeCopy on CheckMode {
  IconData get badgeIcon => switch (this) {
    CheckMode.single => Icons.verified_outlined,
    CheckMode.consensus => Icons.hub_outlined,
    CheckMode.batch => Icons.view_list_rounded,
  };

  String get badge => switch (this) {
    CheckMode.single => 'Model-based check',
    CheckMode.consensus => 'Multi-model panel',
    CheckMode.batch => 'Bulk processing',
  };

  String get title => switch (this) {
    CheckMode.single => 'Single article verification',
    CheckMode.consensus => 'Editorial consensus',
    CheckMode.batch => 'Batch analysis',
  };

  String get subtitle => switch (this) {
    CheckMode.single => 'Submit an article for newsroom analysis.',
    CheckMode.consensus => 'Compare multiple model opinions.',
    CheckMode.batch => 'One article per line.',
  };

  String get action => switch (this) {
    CheckMode.single => 'Verify article',
    CheckMode.consensus => 'Analyze consensus',
    CheckMode.batch => 'Analyze batch',
  };
}

class _RunningState extends StatelessWidget {
  const _RunningState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Analyzing across models…',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
