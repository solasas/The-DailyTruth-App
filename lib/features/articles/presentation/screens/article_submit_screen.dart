import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/brand_app_bar.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/sign_in_required.dart';
import '../providers/articles_providers.dart';

/// **Paper Trail** — paste an article, submit it to the agentic pipeline
/// (`POST /articles/submit` → `202`), then hand off to the verdict poller.
///
/// Laid out like a chat composer: a page header, a centered prompt with
/// quick-start suggestions, and the input pinned to the bottom.
class ArticleSubmitScreen extends ConsumerStatefulWidget {
  const ArticleSubmitScreen({super.key});

  @override
  ConsumerState<ArticleSubmitScreen> createState() =>
      _ArticleSubmitScreenState();
}

class _ArticleSubmitScreenState extends ConsumerState<ArticleSubmitScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _region = TextEditingController();
  final _picker = ImagePicker();
  XFile? _image;

  @override
  void dispose() {
    _region.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setText(String value) {
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    ref.read(articleDraftProvider.notifier).state = value;
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text?.trim() ?? '';
    if (text.isEmpty) {
      SnackbarUtils.showInfo(context, 'Your clipboard has no text to paste.');
      return;
    }
    _setText(text);
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
            _setText('');
            setState(() => _image = null);
            context.push('/verify/$id');
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
      appBar: const BrandAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _PaperTrailHeader(),
            ),
            if (!isAuthed)
              const Expanded(
                child: SignInRequired(
                  message:
                      'Paper Trail runs under your analyst account. Sign in to '
                      'verify articles claim by claim.',
                  redirectTo: '/verify',
                ),
              )
            else ...[
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: _Intro(
                    onPasteArticle: isSubmitting ? null : _pasteFromClipboard,
                    onCheckClaim: isSubmitting
                        ? null
                        : () => _focusNode.requestFocus(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (hasImage)
                      _ImagePreview(
                        file: File(_image!.path),
                        onRemove: isSubmitting
                            ? null
                            : () => setState(() => _image = null),
                      ),
                    TextField(
                      controller: _region,
                      enabled: !isSubmitting,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Region (optional) — e.g. Pune, Kerala',
                        prefixIcon: Icon(Icons.place_outlined, size: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Composer(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: !isSubmitting && !hasImage,
                      hasImage: hasImage,
                      onAttach: isSubmitting ? null : _chooseImageSource,
                      canSend: (hasImage || isValid) && !isSubmitting,
                      isSending: isSubmitting,
                      onChanged: (v) =>
                          ref.read(articleDraftProvider.notifier).state = v,
                      onSend: _submit,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      !hasImage && text.isNotEmpty && !isValid
                          ? 'Enter between ${AppConstants.minPredictTextLength} '
                                'and ${AppConstants.maxPredictTextLength} characters.'
                          : hasImage
                          ? 'Text in the image (Hindi or English) is read automatically.'
                          : '${text.trim().length}/${AppConstants.maxPredictTextLength}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: !hasImage && text.isNotEmpty && !isValid
                            ? theme.colorScheme.error
                            : theme
                                  .extension<AppSemanticColors>()
                                  ?.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Small red document tile + "Paper Trail" title and tagline.
class _PaperTrailHeader extends StatelessWidget {
  const _PaperTrailHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const _IconTile(size: 36),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paper Trail',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              Text(
                'Evidence-grounded verification, claim by claim.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.extension<AppSemanticColors>()?.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(size * 0.24),
      ),
      child: Icon(
        Icons.description_outlined,
        color: AppColors.primary,
        size: size * 0.5,
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.onPasteArticle, required this.onCheckClaim});

  final VoidCallback? onPasteArticle;
  final VoidCallback? onCheckClaim;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.extension<AppSemanticColors>()?.textSecondary;
    return Column(
      children: [
        const _IconTile(size: 56),
        const SizedBox(height: 20),
        Text(
          'What are we fact-checking today?',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Paste a claim or article, or attach a photo or screenshot. Paper Trail extracts its factual claims, '
          'checks each against trusted news outlets and reference sources, '
          'and shows you the receipts.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: secondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _SuggestionPill(
              label: 'Paste a breaking-news article',
              onTap: onPasteArticle,
            ),
            _SuggestionPill(
              label: 'Check a viral social media claim',
              onTap: onCheckClaim,
            ),
          ],
        ),
      ],
    );
  }
}

class _SuggestionPill extends StatelessWidget {
  const _SuggestionPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.cardTheme.color,
      shape: StadiumBorder(side: BorderSide(color: theme.dividerColor)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.extension<AppSemanticColors>()?.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom input bar with a round red send button.
class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.hasImage,
    required this.onAttach,
    required this.canSend,
    required this.isSending,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final bool hasImage;
  final VoidCallback? onAttach;
  final bool canSend;
  final bool isSending;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Attach a photo or screenshot',
            onPressed: onAttach,
            icon: const Icon(Icons.image_outlined),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              minLines: 1,
              maxLines: 6,
              maxLength: AppConstants.maxPredictTextLength,
              keyboardType: TextInputType.multiline,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hasImage ? 'Photo attached' : 'Paste a claim or article…',
                counterText: '',
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Tooltip(
              message: 'Verify',
              child: Material(
                color: canSend || isSending
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.35),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: canSend ? onSend : null,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: isSending
                        ? const Padding(
                            padding: EdgeInsets.all(11),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.file, required this.onRemove});

  final File file;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              file,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton.filled(
              onPressed: onRemove,
              icon: const Icon(Icons.close_rounded),
              tooltip: 'Remove photo',
            ),
          ),
        ],
      ),
    );
  }
}
