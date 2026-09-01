import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/sign_in_required.dart';
import '../providers/articles_providers.dart';

/// Paste an article, submit it to the agentic pipeline (`POST /articles/submit`
/// → `202`), then hand off to the verdict poller.
class ArticleSubmitScreen extends ConsumerStatefulWidget {
  const ArticleSubmitScreen({super.key});

  @override
  ConsumerState<ArticleSubmitScreen> createState() =>
      _ArticleSubmitScreenState();
}

class _ArticleSubmitScreenState extends ConsumerState<ArticleSubmitScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    await ref
        .read(articleSubmitControllerProvider.notifier)
        .submit(_controller.text.trim());

    if (!mounted) return;
    ref
        .read(articleSubmitControllerProvider)
        .whenOrNull(
          data: (id) {
            if (id == null) return;
            ref.read(articleSubmitControllerProvider.notifier).reset();
            context.pushReplacement('/verify/$id');
          },
          error: (error, _) =>
              SnackbarUtils.showError(context, error.toString()),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAuthed = ref.watch(isAuthenticatedProvider);
    final text = ref.watch(articleDraftProvider);
    final isValid = ref.watch(articleDraftValidProvider);
    final isSubmitting = ref.watch(articleSubmitControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify an article')),
      body: SafeArea(
        child: !isAuthed
            ? const SignInRequired(
                message:
                    'Agentic verification runs under your analyst account.',
                redirectTo: '/verify',
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientCard(
                      colors: AppColors.primaryGradient,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.hub_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Multi-step fact check',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'We extract up to ${AppConstants.maxClaims} claims, retrieve evidence '
                            'for each, run entailment, then aggregate an overall verdict.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Article text', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controller,
                      maxLines: 12,
                      minLines: 8,
                      maxLength: AppConstants.maxPredictTextLength,
                      enabled: !isSubmitting,
                      onChanged: (v) =>
                          ref.read(articleDraftProvider.notifier).state = v,
                      decoration: InputDecoration(
                        hintText:
                            'Paste the full article or a substantial excerpt…',
                        alignLabelWithHint: true,
                        counterText:
                            '${text.trim().length}/${AppConstants.maxPredictTextLength}',
                      ),
                    ),
                    if (text.isNotEmpty && !isValid)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Enter between ${AppConstants.minPredictTextLength} and '
                          '${AppConstants.maxPredictTextLength} characters.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    LoadingButton(
                      label: 'Submit for verification',
                      icon: Icons.send_rounded,
                      isLoading: isSubmitting,
                      onPressed: isValid && !isSubmitting ? _submit : null,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
