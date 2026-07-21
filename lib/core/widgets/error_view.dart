import 'package:flutter/material.dart';

import '../error/app_exception.dart';
import '../theme/app_colors.dart';

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
    return Center(
      child: Padding(
        padding: EdgeInsets.all(compact ? 16 : 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icon, size: compact ? 40 : 64, color: AppColors.error),
            SizedBox(height: compact ? 12 : 20),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
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
        ),
      ),
    );
  }
}
