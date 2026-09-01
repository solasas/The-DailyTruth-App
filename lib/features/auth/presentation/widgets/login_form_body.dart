import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/loading_button.dart';
import '../providers/auth_providers.dart';

/// The sign-in form itself, shared by the full [LoginScreen] route and the
/// [LoginSheet] modal. Calls [onResolved] once the user either signs in
/// successfully or chooses to continue as a guest.
class LoginFormBody extends ConsumerStatefulWidget {
  const LoginFormBody({super.key, required this.onResolved});

  final void Function({required bool signedIn}) onResolved;

  @override
  ConsumerState<LoginFormBody> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends ConsumerState<LoginFormBody> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  static const _demoAccounts = [
    ('admin', 'admin123'),
    ('analyst', 'analyst123'),
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    await ref
        .read(authControllerProvider.notifier)
        .login(
          username: _usernameController.text,
          password: _passwordController.text,
        );

    if (!mounted) return;
    ref
        .read(authControllerProvider)
        .when(
          data: (session) {
            if (session == null) return;
            SnackbarUtils.showSuccess(
              context,
              'Signed in as ${session.username}',
            );
            widget.onResolved(signedIn: true);
          },
          error: (error, _) =>
              SnackbarUtils.showError(context, error.toString()),
          loading: () {},
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = ref.watch(authControllerProvider).isLoading;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Sign in', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            'Sign in for review and flagging access.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.username],
            enabled: !isLoading,
            decoration: const InputDecoration(
              hintText: 'Username',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter your username' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscure,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            enabled: !isLoading,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Enter your password' : null,
          ),
          const SizedBox(height: 10),
          Text(
            'Demo: admin / admin123  ·  analyst / analyst123',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: [
              for (final (username, password) in _demoAccounts)
                ActionChip(
                  label: Text(username),
                  onPressed: isLoading
                      ? null
                      : () {
                          _usernameController.text = username;
                          _passwordController.text = password;
                        },
                ),
            ],
          ),
          const SizedBox(height: 20),
          LoadingButton(
            label: 'Sign in',
            icon: Icons.login_rounded,
            isLoading: isLoading,
            onPressed: isLoading ? null : _submit,
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: isLoading
                ? null
                : () => widget.onResolved(signedIn: false),
            child: Text(
              'Continue as guest',
              style: AppTypography.eyebrow(theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
