import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// "The Daily Truth" logotype, drawn with type rather than a bitmap so it
/// stays crisp and follows the theme's ink color.
///
/// * [BrandLogo.stacked] — the web header lockup: a small tracked "THE" over
///   a serif "DAILY TRUTH".
/// * [BrandLogo.inline] — the wordmark "The Daily Truth." with the red full
///   stop.
///
/// The full stop is the brand's status light: pass [dotColor] to tint it
/// with a verdict (red false, green true, amber review).
class BrandLogo extends StatelessWidget {
  const BrandLogo.stacked({super.key, this.size = 22, this.color})
    : _stacked = true,
      dotColor = null;

  const BrandLogo.inline({
    super.key,
    this.size = 28,
    this.color,
    this.dotColor = AppColors.logoDot,
  }) : _stacked = false;

  /// Cap height driver — the serif line's font size.
  final double size;

  /// Ink color; defaults to the theme's primary text color.
  final Color? color;

  final Color? dotColor;

  final bool _stacked;

  @override
  Widget build(BuildContext context) {
    final ink = color ?? Theme.of(context).colorScheme.onSurface;

    if (_stacked) {
      return Semantics(
        label: 'The Daily Truth',
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'THE',
                style: TextStyle(
                  fontFamily: AppTypography.bodyFamily,
                  fontSize: size * 0.42,
                  fontWeight: FontWeight.w700,
                  letterSpacing: size * 0.18,
                  height: 1.1,
                  color: ink,
                ),
              ),
              Text('DAILY TRUTH', style: AppTypography.logo(ink, size)),
            ],
          ),
        ),
      );
    }

    return Semantics(
      label: 'The Daily Truth',
      child: ExcludeSemantics(
        child: Text.rich(
          TextSpan(
            text: 'The Daily Truth',
            style: AppTypography.logo(ink, size),
            children: [
              TextSpan(
                text: '.',
                style: AppTypography.logo(dotColor ?? AppColors.logoDot, size),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The square "T." app mark — dark tile, cream serif T, red dot. Mirrors the
/// launcher icon so in-app branding and the home-screen icon agree.
class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 40,
    this.dotColor = AppColors.logoDot,
    this.inverted = false,
  });

  final double size;
  final Color dotColor;

  /// Cream tile with an ink T (the splash-screen variant).
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final tile = inverted ? AppColors.cream : AppColors.ink;
    final ink = inverted ? AppColors.ink : AppColors.cream;
    return Semantics(
      label: 'The Daily Truth',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: tile,
          borderRadius: BorderRadius.circular(size * 0.22),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'T',
              style: AppTypography.logo(ink, size * 0.62).copyWith(height: 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: size * 0.02, bottom: size * 0.07),
              child: Container(
                width: size * 0.14,
                height: size * 0.14,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
