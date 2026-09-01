import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/settings_local_datasource.dart';
import '../../data/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((
  ref,
) {
  return SettingsLocalDataSourceImpl(ref.watch(sharedPreferencesProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    ref.watch(settingsLocalDataSourceProvider),
    ref.watch(dioClientProvider),
  );
});

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(settingsRepositoryProvider).getThemeMode();

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(settingsRepositoryProvider).setThemeMode(mode);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ApiBaseUrlNotifier extends Notifier<String> {
  @override
  String build() {
    final baseUrl = ref.watch(settingsRepositoryProvider).getApiBaseUrl();
    // Keep the live Dio client pointed at the persisted URL, not just the
    // compile-time default — otherwise a custom URL is forgotten on restart.
    ref.watch(dioClientProvider).updateBaseUrl(baseUrl);
    return baseUrl;
  }

  Future<void> setApiBaseUrl(String baseUrl) async {
    state = baseUrl;
    await ref.read(settingsRepositoryProvider).setApiBaseUrl(baseUrl);
  }
}

final apiBaseUrlProvider = NotifierProvider<ApiBaseUrlNotifier, String>(
  ApiBaseUrlNotifier.new,
);
