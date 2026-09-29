import 'package:flutter/material.dart';

import '../error/app_exception.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Friendly full-panel error state with a retry action, used whenever a
/// [FutureProvider]/[AsyncNotifier] lands in an `AsyncError` state.
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.compact = false,
  });

  final Object error;
  final VoidCallback? onRetry;
  final bool compact;

  IconData get _icon {
    return switch (error) {
      NoInternetFailure() => Icons.wifi_off_rounded,
      TimeoutFailure() => Icons.hourglass_disabled_rounded,
      ServiceUnavailableFailure() => Icons.cloud_off_rounded,
      NotFoundFailure() => Icons.search_off_rounded,
      ValidationFailure() => Icons.warning_amber_rounded,
      PayloadTooLargeFailure() => Icons.text_snippet_outlined,
      _ => Icons.error_outline_rounded,
    };
  }

  String get _message {
    if (error is AppException) return (error as AppException).message;
    return 'Something went wrong. Please try again.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.extension<AppSemanticColors>()?.textSecondary;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 40 : 52,
          height: compact ? 40 : 52,
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: Icon(_icon, size: compact ? 20 : 26, color: AppColors.error),
        ),
        SizedBox(height: compact ? 10 : 16),
        Text(
          'ERROR',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.error,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: secondary),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ],
    );

    if (compact) {
      return Center(
        child: Padding(padding: const EdgeInsets.all(16), child: content),
      );
    }

    // Full-panel variant: the reference's red-bordered error card.
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.45)),
          ),
          child: content,
        ),
      ),
    );
  }
}
