// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/all_models_prediction.dart';
import '../../domain/entities/prediction_result.dart';
import 'prediction_result_dto.dart';

part 'all_models_prediction_dto.freezed.dart';
part 'all_models_prediction_dto.g.dart';

/// Wire format for `POST /predict/all`.
@freezed
class AllModelsPredictionDto with _$AllModelsPredictionDto {
  const factory AllModelsPredictionDto({
    required ConsensusDto consensus,
    @Default([]) List<PredictionResultDto> results,
  }) = _AllModelsPredictionDto;

  const AllModelsPredictionDto._();

  factory AllModelsPredictionDto.fromJson(Map<String, dynamic> json) =>
      _$AllModelsPredictionDtoFromJson(json);

  AllModelsPrediction toEntity() {
    return AllModelsPrediction(
      consensusLabel: consensus.prediction.toUpperCase() == 'FAKE'
          ? PredictionLabel.fake
          : PredictionLabel.real,
      consensusConfidence: consensus.confidence,
      results: results.map((r) => r.toEntity()).toList(),
    );
  }
}

@freezed
class ConsensusDto with _$ConsensusDto {
  const factory ConsensusDto({
    required String prediction,
    @JsonKey(fromJson: _toDouble) @Default(0.0) double confidence,
  }) = _ConsensusDto;

  factory ConsensusDto.fromJson(Map<String, dynamic> json) =>
      _$ConsensusDtoFromJson(json);
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}
