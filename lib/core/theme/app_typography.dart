import 'package:flutter/material.dart';

/// "Organic" type system: **Caprasimo** for display/headline slots only,
/// **Figtree** for everything else.
///
/// Both families are bundled as app assets (see `pubspec.yaml`) rather than
/// fetched at runtime, so they render offline and don't trigger a
/// font-load rebuild mid-frame.
class AppTypography {
  AppTypography._();

  static const String headingFamily = 'Caprasimo';
  static const String bodyFamily = 'Figtree';

  static TextTheme textTheme(Color baseColor) {
    final base = ThemeData(brightness: _brightnessFor(baseColor)).textTheme;

    TextStyle heading(double size) => TextStyle(
      fontFamily: headingFamily,
      fontSize: size,
      height: 1.12,
      color: baseColor,
    );

    TextStyle bodyStyle(double size, FontWeight weight) => TextStyle(
      fontFamily: bodyFamily,
      fontSize: size,
      fontWeight: weight,
      color: baseColor,
    );

    return base
        .copyWith(
          displayLarge: heading(40),
          displayMedium: heading(32),
          displaySmall: heading(28),
          headlineLarge: heading(28),
          headlineMedium: heading(24),
          headlineSmall: heading(20),
          titleLarge: bodyStyle(18, FontWeight.w700),
          titleMedium: bodyStyle(16, FontWeight.w600),
          titleSmall: bodyStyle(14, FontWeight.w600),
          bodyLarge: bodyStyle(16, FontWeight.w400),
          bodyMedium: bodyStyle(14, FontWeight.w400),
          bodySmall: bodyStyle(12, FontWeight.w400),
          labelLarge: bodyStyle(14, FontWeight.w600),
          labelMedium: bodyStyle(12, FontWeight.w600),
          labelSmall: bodyStyle(11, FontWeight.w600),
        )
        .apply(
          fontFamily: bodyFamily,
          bodyColor: baseColor,
          displayColor: baseColor,
        );
  }

  /// Eyebrow/overline label: 11px, heavy, wide tracking.
  static TextStyle eyebrow(Color color) => TextStyle(
    fontFamily: bodyFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.08 * 11,
    color: color,
  );

  static Brightness _brightnessFor(Color color) {
    // Light text -> we're on a dark surface, and vice versa. Only used to
    // seed the base TextTheme geometry; colors are overridden above.
    return color.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light;
  }
}
