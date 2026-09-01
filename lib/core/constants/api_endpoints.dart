/// Central registry of every backend API path.
///
/// Keeping paths here (instead of scattering literals through datasources)
/// means a backend contract change only ever needs one edit.
class ApiEndpoints {
  ApiEndpoints._();

  static const String root = '/';
  static const String health = '/health';

  static const String models = '/models';
  static const String modelsRegistry = '/models/registry';

  static const String predict = '/predict';
  static const String predictAll = '/predict/all';
  static const String predictBatch = '/predict/batch';

  static const String results = '/results';
  static const String resultsCharts = '/results/charts';

  static String resultsChartByName(String name) => '/results/charts/$name';

  // --- Auth ---
  static const String authToken = '/auth/token';

  // --- Agentic article verification ---
  static const String articlesSubmit = '/articles/submit';

  static String articleById(String id) => '/articles/$id';

  // --- Analyst review queue ---
  static const String reviewQueue = '/review-queue';

  static String reviewQueueResolve(String id) => '/review-queue/$id/resolve';
}
