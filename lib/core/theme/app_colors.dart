import 'package:flutter/material.dart';

/// Brand color palette shared by the light and dark themes.
///
/// Semantic colors (success/warning/error) stay constant across themes so
/// that a "FAKE" verdict always reads as red regardless of theme mode.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF60A5FA);

  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFDCFCE7);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);

  // Light theme surfaces
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFE5E7EB);

  // Dark theme surfaces
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF334155);

  static const List<Color> primaryGradient = [
    Color(0xFF2563EB),
    Color(0xFF3B82F6),
    Color(0xFF60A5FA),
  ];

  static const List<Color> successGradient = [
    Color(0xFF16A34A),
    Color(0xFF22C55E),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFDC2626),
    Color(0xFFEF4444),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFF59E0B),
    Color(0xFFFBBF24),
  ];

  /// Category colors for repeatable model-category chips/badges.
  static const Map<String, Color> categoryColors = {
    'classical': Color(0xFF7C3AED),
    'ensemble': Color(0xFF2563EB),
    'deep_learning': Color(0xFFDB2777),
    'transformer': Color(0xFF0891B2),
  };

  static Color categoryColor(String category) {
    return categoryColors[category.toLowerCase().replaceAll(' ', '_')] ??
        primary;
  }
}
