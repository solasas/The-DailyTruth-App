import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/prediction_result.dart';

/// Centralizes the color/icon/label mapping for a [PredictionLabel] so
/// every screen (single result, all-models, history) renders verdicts
/// identically.
extension VerdictVisuals on PredictionLabel {
  Color get color => this == PredictionLabel.fake ? AppColors.error : AppColors.success;

  List<Color> get gradient =>
      this == PredictionLabel.fake ? AppColors.errorGradient : AppColors.successGradient;

  IconData get icon =>
      this == PredictionLabel.fake ? Icons.gpp_bad_rounded : Icons.verified_rounded;

  String get label => this == PredictionLabel.fake ? 'FAKE' : 'REAL';
}
