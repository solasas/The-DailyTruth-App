/// App-wide constant values that are not environment-specific.
class AppConstants {
  AppConstants._();

  static const String appName = 'The DailyTruth';
  static const String appTagline = 'AI-Powered Fake News Detection';
  static const String appVersion = '1.0.0';

  /// Minimum number of characters required before a prediction can be run.
  static const int minAnalysisLength = 20;

  /// Maximum number of characters accepted by the analyze text field.
  static const int maxAnalysisLength = 8000;

  /// Maximum number of recent predictions kept in local history.
  static const int maxRecentPredictions = 200;

  static const Duration defaultConnectTimeout = Duration(seconds: 15);
  static const Duration defaultReceiveTimeout = Duration(seconds: 30);
  static const Duration predictionReceiveTimeout = Duration(seconds: 60);
}
