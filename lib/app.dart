import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/settings/presentation/providers/settings_providers.dart';

/// Root widget: wires the theme mode and GoRouter into [MaterialApp.router].
class TheDailyTruthApp extends ConsumerWidget {
  const TheDailyTruthApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    // Eagerly initialise these on launch so their startup side effects run
    // before the first request: the persisted API base URL is applied to the
    // Dio client, and any saved session's bearer token is installed on it.
    ref.watch(apiBaseUrlProvider);
    ref.watch(authControllerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
