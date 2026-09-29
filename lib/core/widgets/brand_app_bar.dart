import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/presentation/providers/settings_providers.dart';
import 'brand_logo.dart';

/// Top bar for the main tabs, mirroring the reference site header: the
/// stacked "THE / DAILY TRUTH" logo on the left, a round light/dark toggle on
/// the right, and a hairline rule underneath.
class BrandAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BrandAppBar({super.key, this.actions = const []});

  /// Extra actions shown before the theme toggle.
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      toolbarHeight: 64,
      titleSpacing: 20,
      title: const BrandLogo.stacked(size: 20),
      actions: [
        ...actions,
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 16),
          child: CircleIconButton(
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
            icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            onPressed: () => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: theme.dividerColor),
      ),
    );
  }
}

/// 36px round, bordered icon button — the reference header's theme toggle.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          shape: BoxShape.circle,
          border: Border.all(color: theme.dividerColor),
        ),
        child: Icon(
          icon,
          size: 18,
          color: color ?? theme.colorScheme.onSurface,
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
