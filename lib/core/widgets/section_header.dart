import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Section title with the newsroom treatment — a short red rule followed by
/// a heavy upper-case label ("▍EXPLORE MORE") — plus an optional trailing
/// action. Used above list sections (Recent checks, All models, etc).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
        ),
        ?action,
      ],
    );
  }
}
