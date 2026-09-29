import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// Centered page intro used at the top of each tool screen: a red outlined
/// pill badge ("MODEL-BASED CHECK"), a heavy upper-case headline ("SINGLE
/// ARTICLE VERIFICATION") and a one-line subtitle.
class PageHero extends StatelessWidget {
  const PageHero({
    super.key,
    required this.badgeIcon,
    required this.badgeLabel,
    required this.title,
    this.subtitle,
  });

  final IconData badgeIcon;
  final String badgeLabel;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondary = theme.extension<AppSemanticColors>()?.textSecondary;

    return Column(
      children: [
        PillBadge(icon: badgeIcon, label: badgeLabel),
        const SizedBox(height: 16),
        Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(color: secondary),
          ),
        ],
      ],
    );
  }
}

/// Small red outlined capsule with an icon and a tracked, upper-case label.
class PillBadge extends StatelessWidget {
  const PillBadge({
    super.key,
    required this.label,
    this.icon,
    this.color = AppColors.primary,
  });

  final String label;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 6),
          ],
          Text(
            label.toUpperCase(),
            style: AppTypography.eyebrow(color).copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
