import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../models/presentation/providers/models_providers.dart';
import '../providers/prediction_providers.dart';

/// Compose a check: paste text, pick a mode (Single / Consensus / Batch),
/// choose a model, tune the decision threshold, submit.
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
      appBar: AppBar(title: const Text('Check an article')),
      body: SafeArea(
        child: busy
            ? const _RunningState()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<CheckMode>(
                      showSelectedIcon: false,
                      segments: [
                        for (final m in CheckMode.values)
                          ButtonSegment(value: m, label: Text(m.label)),
                      ],
                      selected: {mode},
                      onSelectionChanged: (s) =>
                          ref.read(checkModeProvider.notifier).state = s.first,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _controller,
                      minLines: 6,
                      maxLines: 12,
                      maxLength: mode == CheckMode.batch
                          ? null
                          : AppConstants.maxPredictTextLength,
                      onChanged: (v) =>
                          ref.read(analyzeTextProvider.notifier).state = v,
                      decoration: InputDecoration(
                        hintText: mode == CheckMode.batch
                            ? 'One article or headline per line…'
                            : 'Paste an article or headline…',
                        alignLabelWithHint: true,
                        counterText: '',
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(count, style: theme.textTheme.bodySmall),
                    ),
                    if (mode == CheckMode.batch)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'One item per line · ${AppConstants.minBatchItems}–'
                          '${AppConstants.maxBatchItems} items.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    if (mode.needsModel) ...[
                      const SizedBox(height: 20),
                      Text('Model', style: theme.textTheme.titleSmall),
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
                                    selected: selectedModel == m.name,
                                    onSelected: (_) =>
                                        ref
                                            .read(
                                              selectedModelProvider.notifier,
                                            )
                                            .state = m
                                            .name,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Threshold', style: theme.textTheme.titleSmall),
                        Text(
                          threshold.toStringAsFixed(2),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: threshold,
                      onChanged: (v) =>
                          ref.read(thresholdProvider.notifier).state = v,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: valid ? _run : null,
                        child: const Text('Run check'),
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
      ),
    );
  }
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
