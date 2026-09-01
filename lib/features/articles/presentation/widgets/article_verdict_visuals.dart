import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_enums.dart';

/// Shared colour/icon mapping for agentic-verification verdicts, so the
/// verdict card, claim tiles and history rows all read consistently.
class ArticleVerdictVisuals {
  ArticleVerdictVisuals._();

  static Color color(ArticleVerdict verdict) => switch (verdict) {
    ArticleVerdict.likelyFake => AppColors.error,
    ArticleVerdict.likelyReal => AppColors.success,
    ArticleVerdict.uncertain => AppColors.warning,
  };

  static IconData icon(ArticleVerdict verdict) => switch (verdict) {
    ArticleVerdict.likelyFake => Icons.gpp_bad_rounded,
    ArticleVerdict.likelyReal => Icons.verified_rounded,
    ArticleVerdict.uncertain => Icons.help_outline_rounded,
  };

  static Color claimColor(ClaimVerdict verdict) => switch (verdict) {
    ClaimVerdict.entailment => AppColors.success,
    ClaimVerdict.contradiction => AppColors.error,
    ClaimVerdict.neutral => AppColors.textSecondaryLight,
    ClaimVerdict.unverifiable => AppColors.warning,
  };

  static IconData claimIcon(ClaimVerdict verdict) => switch (verdict) {
    ClaimVerdict.entailment => Icons.check_circle_rounded,
    ClaimVerdict.contradiction => Icons.cancel_rounded,
    ClaimVerdict.neutral => Icons.remove_circle_outline_rounded,
    ClaimVerdict.unverifiable => Icons.hourglass_empty_rounded,
  };

  static Color degradationColor(DegradationSeverity severity) =>
      switch (severity) {
        DegradationSeverity.major => AppColors.error,
        DegradationSeverity.minor => AppColors.warning,
        DegradationSeverity.info => AppColors.primary,
      };
}
