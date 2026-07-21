import 'package:flutter/material.dart';

/// Contract for reading/writing user-configurable app settings.
abstract class SettingsRepository {
  ThemeMode getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);

  String getApiBaseUrl();
  Future<void> setApiBaseUrl(String baseUrl);

  Future<void> clearCache();
}
