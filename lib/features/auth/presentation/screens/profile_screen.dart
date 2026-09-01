import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../domain/entities/auth_session.dart';
import '../providers/auth_providers.dart';
import '../widgets/login_sheet.dart';

/// The "Profile" tab destination — account state plus the app's settings /
/// analyst entry points that no longer have their own bottom-nav tab.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final session = ref.watch(authControllerProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (session == null)
            GradientCard(
              colors: AppColors.primaryGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GUEST',
                    style: AppTypography.eyebrow(
                      theme.colorScheme.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Not signed in',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sign in to submit articles for verification and work the review queue.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(
                        alpha: 0.92,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.onPrimary,
                      foregroundColor: AppColors.primary,
                    ),
                    onPressed: () => LoginSheet.show(context),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            )
          else
            GradientCard(
              colors: AppColors.successGradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.role.label.toUpperCase(),
                    style: AppTypography.eyebrow(
                      theme.colorScheme.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    session.username,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onPrimary,
                      side: BorderSide(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await ref.read(authControllerProvider.notifier).logout();
                      if (context.mounted) {
                        SnackbarUtils.showInfo(context, 'Signed out');
                      }
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
          _NavCard(
            icon: Icons.search_rounded,
            title: 'Check history',
            subtitle: 'Your recent checks, stored on this device',
            onTap: () => context.push('/history'),
          ),
          if (session != null && session.role.canResolveReviews)
            _NavCard(
              icon: Icons.fact_check_outlined,
              title: 'Review queue',
              subtitle: 'Resolve flagged predictions',
              onTap: () => context.push('/review-queue'),
            ),
          _NavCard(
            icon: Icons.leaderboard_rounded,
            title: 'Benchmarks',
            subtitle: 'Model leaderboard and charts',
            onTap: () => context.push('/leaderboard'),
          ),
          _NavCard(
            icon: Icons.settings_rounded,
            title: 'Settings',
            subtitle: 'Theme, API endpoint, storage',
            onTap: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.bodyLarge),
                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
