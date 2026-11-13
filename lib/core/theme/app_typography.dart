import 'package:flutter/material.dart';

/// "Newsroom" type system: **Inter** for everything — heavy (800/900),
/// tightly tracked display/headline slots and regular-weight body copy — plus
/// **Playfair Display** reserved for the serif logo wordmark.
///
/// All families are bundled as app assets (see `pubspec.yaml`) rather than
/// fetched at runtime, so they render offline and don't trigger a
/// font-load rebuild mid-frame.
class AppTypography {
  AppTypography._();

  static const String headingFamily = 'Inter';
  static const String bodyFamily = 'Inter';
  static const String logoFamily = 'PlayfairDisplay';

  static TextTheme textTheme(Color baseColor) {
    final base = ThemeData(brightness: _brightnessFor(baseColor)).textTheme;

    TextStyle heading(double size, {FontWeight weight = FontWeight.w900}) =>
        TextStyle(
          fontFamily: headingFamily,
          fontSize: size,
          fontWeight: weight,
          height: 1.08,
          letterSpacing: -0.03 * size,
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
          headlineLarge: heading(28, weight: FontWeight.w800),
          headlineMedium: heading(24, weight: FontWeight.w800),
          headlineSmall: heading(20, weight: FontWeight.w800),
          titleLarge: bodyStyle(18, FontWeight.w800),
          titleMedium: bodyStyle(16, FontWeight.w700),
          titleSmall: bodyStyle(14, FontWeight.w600),
          bodyLarge: bodyStyle(16, FontWeight.w400),
          bodyMedium: bodyStyle(14, FontWeight.w400),
          bodySmall: bodyStyle(12, FontWeight.w400),
          labelLarge: bodyStyle(14, FontWeight.w700),
          labelMedium: bodyStyle(12, FontWeight.w600),
          labelSmall: bodyStyle(11, FontWeight.w600),
        )
        .apply(
          fontFamily: bodyFamily,
          bodyColor: baseColor,
          displayColor: baseColor,
        );
  }

  /// Eyebrow/overline label: 11px, heavy, very wide tracking (the reference's
  /// "MODEL-BASED CHECK" / "PROJECT TEAM" labels). Callers upper-case the
  /// text themselves.
  static TextStyle eyebrow(Color color) => TextStyle(
    fontFamily: bodyFamily,
    fontSize: 11,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.2 * 11,
    color: color,
  );

  /// Serif logo wordmark style ("The Daily Truth.").
  static TextStyle logo(Color color, double size) => TextStyle(
    fontFamily: logoFamily,
    fontSize: size,
    fontWeight: FontWeight.w900,
    height: 1.0,
    letterSpacing: -0.01 * size,
    color: color,
  );

  static Brightness _brightnessFor(Color color) {
    // Light text -> we're on a dark surface, and vice versa. Only used to
    // seed the base TextTheme geometry; colors are overridden above.
    return color.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light;
  }
}
