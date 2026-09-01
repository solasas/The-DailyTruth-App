import 'package:flutter/material.dart';

/// "Organic" brand palette — warm cream grounds, terracotta as the
/// alert/"fake" voice, sage as the verified/"real" voice, plus a warm
/// neutral ramp. Shared by the light and dark themes.
///
/// Semantic roles stay constant across themes so a "fake" verdict always
/// reads as terracotta and a "real" verdict as sage regardless of mode.
class AppColors {
  AppColors._();

  // --- Terracotta ramp (accent / "fake" / alert voice) ---
  static const Color accent100 = Color(0xFFFFF2EB);
  static const Color accent300 = Color(0xFFE7A87E);
  static const Color accent500 = Color(0xFFC67139);
  static const Color accent700 = Color(0xFF8A4A24);
  static const Color accent800 = Color(0xFF643312);

  // --- Sage ramp (accent-2 / "real" / verified voice) ---
  static const Color sage100 = Color(0xFFF0FAE1);
  static const Color sage300 = Color(0xFFAFBE8F);
  static const Color sage500 = Color(0xFF7A8A5E);
  static const Color sage700 = Color(0xFF556141);
  static const Color sage800 = Color(0xFF3D472B);

  // --- Warm neutral ramp ---
  static const Color neutral100 = Color(0xFFF9F4ED);
  static const Color neutral200 = Color(0xFFEEE7DB);
  static const Color neutral300 = Color(0xFFDCD3C4);
  static const Color neutral400 = Color(0xFFC0B6A5);
  static const Color neutral600 = Color(0xFF82796A);
  static const Color neutral800 = Color(0xFF474238);

  static const Color ink = Color(0xFF201E1D);

  // --- Primary (maps to terracotta) ---
  static const Color primary = accent500;
  static const Color primaryDark = accent700;
  static const Color primaryLight = accent300;

  // --- Semantic (constant across themes) ---
  static const Color success = sage500; // "likely real"
  static const Color successLight = sage100;

  static const Color warning = neutral600; // "uncertain"
  static const Color warningLight = neutral200;

  static const Color error = accent500; // "likely fake"
  static const Color errorLight = accent100;

  // --- Light theme surfaces ---
  static const Color backgroundLight = Color(0xFFF5EAD8);
  static const Color cardLight = Color(0xFFFBF4E8);
  static const Color surfaceSunkenLight = Color(0xFFEBDDC5);
  static const Color textPrimaryLight = ink;
  static const Color textSecondaryLight = neutral600;
  static const Color borderLight = neutral300;

  // --- Dark theme surfaces (warm charcoal, not blue-black) ---
  static const Color backgroundDark = Color(0xFF201E1D);
  static const Color cardDark = Color(0xFF2B2723);
  static const Color surfaceSunkenDark = Color(0xFF34302B);
  static const Color textPrimaryDark = Color(0xFFF5EAD8);
  static const Color textSecondaryDark = Color(0xFFC0B6A5);
  static const Color borderDark = Color(0xFF474238);

  /// Ink-tinted shadow, used by cards/sheets instead of pure black.
  static Color shadow(double opacity) => ink.withValues(alpha: opacity);

  static const List<Color> primaryGradient = [
    Color(0xFFC67139),
    Color(0xFFD98F55),
    Color(0xFFE7A87E),
  ];

  static const List<Color> successGradient = [
    Color(0xFF7A8A5E),
    Color(0xFF93A277),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFC67139),
    Color(0xFFD98F55),
  ];

  static const List<Color> warningGradient = [
    Color(0xFF9A8F7C),
    Color(0xFFB7AC98),
  ];

  /// Category colors for model-category chips/badges. The prototype defines a
  /// 3-way mapping (Classical ML → neutral, Deep Learning → accent, Hybrid →
  /// accent-2); other categories fall back along the same three voices.
  static Color categoryColor(String category) {
    final normalized = category.toLowerCase();
    if (normalized.contains('deep') ||
        normalized.contains('neural') ||
        normalized.contains('transformer') ||
        normalized.contains('bert')) {
      return accent500;
    }
    if (normalized.contains('hybrid') || normalized.contains('ensemble')) {
      return sage500;
    }
    if (normalized.contains('classical')) {
      return neutral600;
    }
    return neutral600;
  }
}
