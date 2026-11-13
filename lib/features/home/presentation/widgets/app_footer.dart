import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

/// Site footer from the reference: brand line + tagline, a hairline rule,
/// then the project-team credit block.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  static const _team =
      'Kavish Basole · Nishik Varma · Sashank Solasa · Virat Tallapally';
  static const _guide = 'Prof. Ganesh Reddy Karri';
  static const _term = 'Fall Semester 2026–27';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary =
        theme.extension<AppSemanticColors>()?.textSecondary ??
        theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.appName.toUpperCase(),
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          Text(
            'AI Powered Fake News Detection Platform',
            style: theme.textTheme.bodyMedium?.copyWith(color: secondary),
          ),
          const SizedBox(height: 20),
          Divider(height: 1, color: theme.dividerColor),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Text(
                  'PROJECT TEAM',
                  style: AppTypography.eyebrow(AppColors.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  _team,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: 'Under the guidance of ',
                    children: [
                      TextSpan(
                        text: _guide,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const TextSpan(text: ' — $_term'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(color: secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
