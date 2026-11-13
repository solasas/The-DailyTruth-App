import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

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
  final _region = TextEditingController();
  final _picker = ImagePicker();
  XFile? _image;

  @override
  void dispose() {
    _controller.dispose();
    _region.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _picker.pickImage(source: source);
      if (file != null && mounted) setState(() => _image = file);
    } catch (_) {
      if (mounted) {
        SnackbarUtils.showError(context, 'Could not open the photo picker.');
      }
    }
  }

  void _chooseImageSource() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Choose from library'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_rounded),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final notifier = ref.read(articleSubmitControllerProvider.notifier);
    final region = _region.text.trim();
    final image = _image;
    if (image != null) {
      await notifier.submitImage(image.path, region: region);
    } else {
      await notifier.submit(_controller.text.trim(), region: region);
    }

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
    final hasImage = _image != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify a claim or article')),
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
                            'We extract the claims, check each against sources with an '
                            'NLI model, trace where it first appeared, then fuse an '
                            'overall verdict.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      hasImage ? 'Photo or screenshot' : 'Claim or article',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (hasImage)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.file(
                              File(_image!.path),
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton.filled(
                              onPressed: isSubmitting
                                  ? null
                                  : () => setState(() => _image = null),
                              icon: const Icon(Icons.close_rounded),
                              tooltip: 'Remove photo',
                            ),
                          ),
                        ],
                      )
                    else ...[
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
                              'Paste a claim (one or two sentences) or a full article…',
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
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: isSubmitting ? null : _chooseImageSource,
                        icon: const Icon(Icons.image_search_rounded),
                        label: const Text('Use a photo or screenshot instead'),
                      ),
                    ],
                    if (hasImage)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'The text in the image (Hindi or English) is read '
                          'automatically, then checked like any other claim.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _region,
                      enabled: !isSubmitting,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Region (optional)',
                        hintText: 'e.g. Pune, Kerala',
                        helperText:
                            'Where the claim is about, if the text does not say.',
                        prefixIcon: Icon(Icons.place_outlined),
                      ),
                    ),
                    const SizedBox(height: 20),
                    LoadingButton(
                      label: 'Submit for verification',
                      icon: Icons.send_rounded,
                      isLoading: isSubmitting,
                      onPressed: (hasImage || isValid) && !isSubmitting
                          ? _submit
                          : null,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
