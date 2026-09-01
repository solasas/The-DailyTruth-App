import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_state.dart';
import 'login_sheet.dart';

/// Placeholder shown in place of a Bearer-protected screen's content when the
/// user is signed out. Opens the sign-in bottom sheet.
class SignInRequired extends StatelessWidget {
  const SignInRequired({
    super.key,
    this.message = 'Sign in to continue.',
    this.redirectTo,
  });

  final String message;

  /// Kept for call-site compatibility; the sheet returns in place so there's
  /// nothing to redirect to.
  final String? redirectTo;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.lock_outline_rounded,
      title: 'Sign-in required',
      subtitle: message,
      action: FilledButton.icon(
        onPressed: () => LoginSheet.show(context),
        icon: const Icon(Icons.login_rounded),
        label: const Text('Sign in'),
      ),
    );
  }
}
