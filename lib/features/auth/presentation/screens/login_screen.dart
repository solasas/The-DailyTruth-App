import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/login_form_body.dart';

/// Full-screen sign-in, used for deep links / `SignInRequired` redirects.
/// The primary in-app path is the `LoginSheet` bottom sheet.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key, this.redirectTo});

  final String? redirectTo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: LoginFormBody(
              onResolved: ({required signedIn}) {
                if (signedIn && redirectTo != null) {
                  context.go(redirectTo!);
                } else if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
