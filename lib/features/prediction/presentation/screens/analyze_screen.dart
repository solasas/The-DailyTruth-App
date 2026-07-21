import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../models/presentation/providers/models_providers.dart';
import '../providers/prediction_providers.dart';
import '../widgets/model_dropdown.dart';

/// Lets the user paste/type an article and analyze it either with one
/// selected model or with every loaded model at once.
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

  Future<void> _analyzeSingle() async {
    final model = ref.read(selectedModelProvider);
    if (model == null) {
      SnackbarUtils.showInfo(context, 'Please select a model first.');
      return;
    }
    final text = _controller.text.trim();
    await ref.read(singlePredictionProvider.notifier).analyze(text: text, modelName: model);

    if (!mounted) return;
    final state = ref.read(singlePredictionProvider);
    state.whenOrNull(
      data: (result) {
        if (result != null) context.push('/analyze/result');
      },
      error: (error, _) => SnackbarUtils.showError(context, error.toString()),
    );
  }

  Future<void> _analyzeAll() async {
    final text = _controller.text.trim();
    await ref.read(allModelsPredictionProvider.notifier).analyzeAll(text: text);

    if (!mounted) return;
    final state = ref.read(allModelsPredictionProvider);
    state.whenOrNull(
      data: (result) {
        if (result != null) context.push('/analyze/result-all');
      },
      error: (error, _) => SnackbarUtils.showError(context, error.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(analyzeTextProvider);
    final isValid = ref.watch(analyzeTextValidProvider);
    final loadedModelsAsync = ref.watch(loadedModelsProvider);
    final selectedModel = ref.watch(selectedModelProvider);
    final singleLoading = ref.watch(singlePredictionProvider).isLoading;
    final allLoading = ref.watch(allModelsPredictionProvider).isLoading;
    final isBusy = singleLoading || allLoading;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Analyze News')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paste an article or headline', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                'Minimum ${AppConstants.minAnalysisLength} characters required.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                maxLines: 10,
                minLines: 6,
                maxLength: AppConstants.maxAnalysisLength,
                enabled: !isBusy,
                onChanged: (value) => ref.read(analyzeTextProvider.notifier).state = value,
                decoration: InputDecoration(
                  hintText: 'e.g. "Scientists confirm the moon is actually...',
                  alignLabelWithHint: true,
                  counterText: '${text.trim().length}/${AppConstants.maxAnalysisLength}',
                ),
              ),
              if (text.isNotEmpty && !isValid)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Enter at least ${AppConstants.minAnalysisLength} characters.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              const SizedBox(height: 20),
              loadedModelsAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text(
                  'Could not load models: $error',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                ),
                data: (models) {
                  if (models.isEmpty) {
                    return Text(
                      'No models are currently loaded on the server.',
                      style: theme.textTheme.bodySmall,
                    );
                  }
                  return ModelDropdown(
                    models: models,
                    selectedModel: selectedModel,
                    onChanged: isBusy
                        ? null
                        : (value) => ref.read(selectedModelProvider.notifier).state = value,
                  );
                },
              ),
              const SizedBox(height: 24),
              LoadingButton(
                label: 'Analyze using selected model',
                icon: Icons.search_rounded,
                isLoading: singleLoading,
                onPressed: isValid && !isBusy && selectedModel != null ? _analyzeSingle : null,
              ),
              const SizedBox(height: 12),
              LoadingButton(
                label: 'Analyze using all models',
                icon: Icons.hub_rounded,
                outlined: true,
                isLoading: allLoading,
                onPressed: isValid && !isBusy ? _analyzeAll : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
