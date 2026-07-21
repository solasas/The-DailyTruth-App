/// Compile-time defaults for the app's environment.
///
/// The base URL here is only the *default* — users can override it at
/// runtime from the Settings screen, persisted via
/// `SettingsLocalDataSource` (see features/settings).
class EnvConfig {
  EnvConfig._();

  /// Default backend base URL, overridable with
  /// `--dart-define=API_BASE_URL=https://your-host`.
  static const String defaultApiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );

  static const bool enableNetworkLogs = bool.fromEnvironment(
    'ENABLE_NETWORK_LOGS',
    defaultValue: true,
  );
}
