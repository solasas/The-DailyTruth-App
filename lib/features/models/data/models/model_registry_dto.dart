import '../../domain/entities/model_registry_entry.dart';

/// Hand-rolled parsing for `GET /models/registry`.
///
/// Accepts a bare list of entries or an envelope
/// (`{"models": [...]}` / `{"registry": [...]}` / `{"entries": [...]}`),
/// with metrics either inline or nested under `metrics`.
class ModelRegistryDto {
  ModelRegistryDto._();

  static ModelRegistry parse(dynamic data) {
    List<dynamic> rawList;
    DateTime? generatedAt;

    if (data is List) {
      rawList = data;
    } else if (data is Map) {
      final map = data.cast<String, dynamic>();
      rawList =
          (map['models'] ??
                  map['registry'] ??
                  map['entries'] ??
                  map['items'] ??
                  const [])
              as List;
      generatedAt = _date(map['generated_at'] ?? map['updated_at']);
    } else {
      rawList = const [];
    }

    return ModelRegistry(
      entries: rawList
          .whereType<Map>()
          .map((e) => parseEntry(e.cast<String, dynamic>()))
          .toList(),
      generatedAt: generatedAt,
    );
  }

  static ModelRegistryEntry parseEntry(Map<String, dynamic> json) {
    final metrics =
        (json['metrics'] as Map?)?.cast<String, dynamic>() ?? const {};
    final name = (json['name'] ?? json['model_name'] ?? '').toString();

    double m(String key, [String? alt]) => _toDouble(
      metrics[key] ?? (alt != null ? metrics[alt] : null) ?? json[key],
    );

    return ModelRegistryEntry(
      name: name,
      displayName: json['display_name'] as String? ?? name,
      category: json['category'] as String? ?? 'unknown',
      featureType: json['feature_type'] as String? ?? 'unknown',
      loaded: json['loaded'] as bool? ?? false,
      version: (json['version'] ?? json['model_version'])?.toString(),
      accuracy: m('accuracy'),
      f1Score: m('f1', 'f1_score'),
      precision: m('precision'),
      recall: m('recall'),
      auc: m('auc', 'roc_auc'),
      charts: _charts(
        json['charts'] ?? json['chart_names'] ?? json['artifacts'],
      ),
      trainedAt: _date(json['trained_at'] ?? json['created_at']),
    );
  }

  static List<String> _charts(dynamic v) {
    if (v is List) return v.map((e) => e.toString()).toList();
    if (v is Map) return v.keys.map((e) => e.toString()).toList();
    return const [];
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(
        value < 1e12 ? value * 1000 : value,
      );
    }
    return DateTime.tryParse(value.toString());
  }
}
