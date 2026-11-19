/// Compile-time defaults for the app's environment.
///
/// The backend URL is fixed at build time; override it for local development
/// with `--dart-define=API_BASE_URL=http://<lan-ip>:8000`.
class EnvConfig {
  EnvConfig._();

  /// Default backend base URL, overridable with
  /// `--dart-define=API_BASE_URL=https://your-host`.
  static const String defaultApiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api-thedailytruth.nishik.live',
  );

  static const bool enableNetworkLogs = bool.fromEnvironment(
    'ENABLE_NETWORK_LOGS',
    defaultValue: true,
  );
}
