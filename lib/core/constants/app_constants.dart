/// App-wide constant values that are not environment-specific.
class AppConstants {
  AppConstants._();

  static const String appName = 'The Daily Truth';
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

  // --- Backend client-side constraints (mirrors backend .env / validators) ---

  /// `/predict` text bounds enforced by the backend (`text` 5–50 000 chars).
  static const int minPredictTextLength = 5;
  static const int maxPredictTextLength = 50000;

  /// `/predict/batch` accepts between 1 and 100 texts per request.
  static const int minBatchItems = 1;
  static const int maxBatchItems = 100;

  /// Backend `MAX_CLAIMS` — the agentic pipeline verifies at most this many
  /// claims extracted from a submitted article.
  static const int maxClaims = 5;

  /// Backend `STAGE_TIMEOUT_S` — a single agentic stage is abandoned after
  /// this long; surfaced in the UI so long-running stages look intentional.
  static const Duration agenticStageTimeout = Duration(seconds: 90);

  /// How often `GET /articles/{id}` is polled while a verification job is
  /// `processing` (submit → 202 → poll).
  static const Duration verificationPollInterval = Duration(milliseconds: 1500);

  /// Give up polling a verification job after this long. Kept comfortably
  /// above `STAGE_TIMEOUT_S` × the number of pipeline stages.
  static const Duration verificationTimeout = Duration(seconds: 240);

  /// Backend `JWT_EXPIRE_MINUTES` (60) — used as a fallback token lifetime
  /// when `POST /auth/token` doesn't echo an explicit expiry.
  static const Duration tokenLifetimeFallback = Duration(minutes: 60);

  /// Default page size for the analyst review queue.
  static const int reviewQueuePageSize = 20;
}
