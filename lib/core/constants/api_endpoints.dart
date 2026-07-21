/// Central registry of every backend API path.
///
/// Keeping paths here (instead of scattering literals through datasources)
/// means a backend contract change only ever needs one edit.
class ApiEndpoints {
  ApiEndpoints._();

  static const String root = '/';
  static const String health = '/health';
  static const String models = '/models';
  static const String predict = '/predict';
  static const String predictAll = '/predict/all';
  static const String predictBatch = '/predict/batch';
  static const String results = '/results';
  static const String resultsCharts = '/results/charts';

  static String resultsChartByName(String name) => '/results/charts/$name';
}
