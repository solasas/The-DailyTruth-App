import '../../domain/entities/chart_info.dart';

/// Wire format for a single entry of `GET /results/charts`.
///
/// Handles both a bare list of filename strings and a list of
/// `{"name": ..., "title": ...}` objects, since chart-listing endpoints
/// commonly return either shape.
class ChartInfoDto {
  const ChartInfoDto({required this.name, this.title});

  final String name;
  final String? title;

  factory ChartInfoDto.fromDynamic(dynamic raw) {
    if (raw is String) return ChartInfoDto(name: raw);
    if (raw is Map) {
      final name = (raw['name'] ?? raw['filename'] ?? raw['file']).toString();
      final title = raw['title']?.toString() ?? raw['label']?.toString();
      return ChartInfoDto(name: name, title: title);
    }
    throw FormatException('Unsupported chart entry: $raw');
  }

  ChartInfo toEntity() {
    return ChartInfo(name: name, title: title ?? _titleize(name));
  }

  static String _titleize(String fileName) {
    final withoutExtension = fileName.split('.').first;
    return withoutExtension
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
