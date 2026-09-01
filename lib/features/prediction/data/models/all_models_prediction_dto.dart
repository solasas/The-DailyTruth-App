import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/all_models_prediction.dart';
import '../../domain/entities/prediction_result.dart';
import 'prediction_result_dto.dart';

part 'all_models_prediction_dto.freezed.dart';

/// Wire format for `POST /predict/all`.
///
/// The backend returns `consensus` as a bare "real"/"fake" string and
/// `consensus_confidence` as a sibling field (not a nested object), so this
/// is parsed by hand rather than via json_serializable.
@freezed
class AllModelsPredictionDto with _$AllModelsPredictionDto {
  const factory AllModelsPredictionDto({
    required String consensus,
    @Default(0.0) double consensusConfidence,
    @Default([]) List<PredictionResultDto> results,
  }) = _AllModelsPredictionDto;

  const AllModelsPredictionDto._();

  factory AllModelsPredictionDto.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'] as List? ?? const [];
    return AllModelsPredictionDto(
      consensus: (json['consensus'] as String? ?? 'real').toLowerCase(),
      consensusConfidence: _toDouble(json['consensus_confidence']),
      results: rawResults
          .map((e) => PredictionResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  AllModelsPrediction toEntity() {
    return AllModelsPrediction(
      consensusLabel: consensus == 'fake'
          ? PredictionLabel.fake
          : PredictionLabel.real,
      consensusConfidence: consensusConfidence,
      results: results.map((r) => r.toEntity()).toList(),
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
