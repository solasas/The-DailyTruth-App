import 'package:flutter/material.dart';

/// "Newsroom" brand palette — near-black grounds, a hard newsprint red as the
/// accent/alert/"fake" voice, green as the verified/"real" voice, amber as
/// the "needs review" voice, plus a cool neutral ramp. Shared by the light
/// and dark themes.
///
/// Semantic roles stay constant across themes so a "fake" verdict always
/// reads as red and a "real" verdict as green regardless of mode — the same
/// status system the logo's dot uses (red false, green true, amber review).
///
/// Ramp names (`accent*`, `sage*`, `neutral*`) are kept stable so existing
/// widgets pick up the palette without per-call-site changes.
class AppColors {
  AppColors._();

  // --- Red ramp (accent / "fake" / alert voice) ---
  static const Color accent100 = Color(0xFFFFE9E7);
  static const Color accent300 = Color(0xFFFF6B5E);
  static const Color accent500 = Color(0xFFE10600);
  static const Color accent700 = Color(0xFFB80500);
  static const Color accent800 = Color(0xFF7A0300);

  // --- Green ramp (accent-2 / "real" / verified voice) ---
  static const Color sage100 = Color(0xFFE3F7EA);
  static const Color sage300 = Color(0xFF7BD89C);
  static const Color sage500 = Color(0xFF22A45D);
  static const Color sage700 = Color(0xFF17773F);
  static const Color sage800 = Color(0xFF0F5530);

  // --- Amber ("needs review" voice, end of the red→amber accent stripe) ---
  static const Color amber500 = Color(0xFFE8A317);
  static const Color amber100 = Color(0xFFFFF4DB);

  // --- Neutral ramp ---
  static const Color neutral100 = Color(0xFFF4F2EE);
  static const Color neutral200 = Color(0xFFE7E4DE);
  static const Color neutral300 = Color(0xFFD6D2CA);
  static const Color neutral400 = Color(0xFF9A9A9A);
  static const Color neutral600 = Color(0xFF6B6B6B);
  static const Color neutral800 = Color(0xFF2A2A2A);

  static const Color ink = Color(0xFF141312);

  // --- Logo ---
  /// The logo's red full stop — slightly warmer than the UI red, matching the
  /// "The Daily Truth." / "T." marks.
  static const Color logoDot = Color(0xFFE2463C);

  /// Cream ground used behind the dark logo mark / light-mode surfaces.
  static const Color cream = Color(0xFFF3EFE8);

  // --- Primary (maps to red) ---
  static const Color primary = accent500;
  static const Color primaryDark = accent700;
  static const Color primaryLight = accent300;

  // --- Semantic (constant across themes) ---
  static const Color success = sage500; // "likely real"
  static const Color successLight = sage100;

  static const Color warning = amber500; // "uncertain"
  static const Color warningLight = amber100;

  static const Color error = accent500; // "likely fake"
  static const Color errorLight = accent100;

  // --- Light theme surfaces ---
  static const Color backgroundLight = cream;
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surfaceSunkenLight = Color(0xFFEDE9E1);
  static const Color textPrimaryLight = ink;
  static const Color textSecondaryLight = Color(0xFF5F5C57);
  static const Color borderLight = neutral300;

  // --- Dark theme surfaces (near-black newsroom) ---
  static const Color backgroundDark = Color(0xFF0B0B0B);
  static const Color cardDark = Color(0xFF1A1A1A);
  static const Color surfaceSunkenDark = Color(0xFF0E0E0E);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFA3A3A3);
  static const Color borderDark = neutral800;

  /// Neutral shadow, used by cards/sheets.
  static Color shadow(double opacity) =>
      Colors.black.withValues(alpha: opacity);

  /// Solid-red hero fill (white text sits on it).
  static const List<Color> primaryGradient = [
    Color(0xFFE10600),
    Color(0xFFB80500),
  ];

  /// Thin red→amber stripe across the top of input/feature cards.
  static const List<Color> accentStripe = [
    Color(0xFFE10600),
    Color(0xFFE8551A),
    Color(0xFFE8A317),
  ];

  static const List<Color> successGradient = [
    Color(0xFF22A45D),
    Color(0xFF17773F),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFE10600),
    Color(0xFFB80500),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFE8A317),
    Color(0xFFC7850A),
  ];

  /// Category colors for model-category chips/badges: Classical ML →
  /// neutral, Deep Learning → red, Hybrid → green; other categories fall
  /// back along the same three voices.
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
    return neutral400;
  }
}
