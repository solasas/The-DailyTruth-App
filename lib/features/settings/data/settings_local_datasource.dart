import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/env_config.dart';

abstract class SettingsLocalDataSource {
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);

  String getApiBaseUrl();
  Future<void> setApiBaseUrl(String baseUrl);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'settings.theme_mode';
  static const _apiBaseUrlKey = 'settings.api_base_url';

  @override
  ThemeMode getThemeMode() {
    final value = _prefs.getString(_themeModeKey);
    return switch (value) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      // Dark newsroom look is the brand default until the user picks.
      _ => ThemeMode.dark,
    };
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _prefs.setString(_themeModeKey, mode.name);
  }

  @override
  String getApiBaseUrl() {
    // The URL is no longer user-editable; ignore any value saved by older
    // builds so a stale address can't override the configured backend.
    return EnvConfig.defaultApiBaseUrl;
  }

  @override
  Future<void> setApiBaseUrl(String baseUrl) {
    return _prefs.setString(_apiBaseUrlKey, baseUrl);
  }
}
