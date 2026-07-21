import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Poppins-based typography hierarchy applied on top of Material 3's
/// [TextTheme] slots so every widget that reads `Theme.of(context).textTheme`
/// automatically gets the right weight/size without extra plumbing.
class AppTypography {
  AppTypography._();

  static TextTheme textTheme(Color baseColor) {
    final base = GoogleFonts.poppinsTextTheme();
    return base
        .copyWith(
          displayLarge: base.displayLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: baseColor,
          ),
          displayMedium: base.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: baseColor,
          ),
          headlineLarge: base.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: baseColor,
            fontSize: 28,
          ),
          headlineMedium: base.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: baseColor,
            fontSize: 24,
          ),
          headlineSmall: base.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: baseColor,
            fontSize: 20,
          ),
          titleLarge: base.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: baseColor,
            fontSize: 18,
          ),
          titleMedium: base.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: baseColor,
            fontSize: 16,
          ),
          titleSmall: base.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: baseColor,
            fontSize: 14,
          ),
          bodyLarge: base.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: baseColor,
            fontSize: 16,
          ),
          bodyMedium: base.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: baseColor,
            fontSize: 14,
          ),
          bodySmall: base.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: baseColor,
            fontSize: 12,
          ),
          labelLarge: base.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: baseColor,
            fontSize: 14,
          ),
        )
        .apply(bodyColor: baseColor, displayColor: baseColor);
  }
}
