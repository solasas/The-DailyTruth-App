import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/login_sheet.dart';
import '../../../prediction/presentation/providers/prediction_providers.dart';
import '../../../prediction/presentation/widgets/recent_prediction_tile.dart';
import '../providers/home_providers.dart';
import '../../domain/entities/server_health.dart';

/// Landing screen: brand header, a hero call-to-action into the check flow,
/// and a feed of the device's recent checks.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _onRefresh(WidgetRef ref) async {
    ref.invalidate(serverHealthProvider);
    ref.invalidate(predictionHistoryProvider);
    try {
      await ref.read(serverHealthProvider.future);
    } catch (_) {
      // Surfaced by the health dot; pull-to-refresh just needs to complete.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final historyAsync = ref.watch(predictionHistoryProvider);
    final healthAsync = ref.watch(serverHealthProvider);
    final isAuthed = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        titleSpacing: 20,
        title: Row(
          children: [
            _HealthDot(healthAsync: healthAsync),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppConstants.appName,
                style: theme.textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () =>
                  isAuthed ? context.go('/profile') : LoginSheet.show(context),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Icon(
                  isAuthed
                      ? Icons.person_rounded
                      : Icons.person_outline_rounded,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(ref),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  FadeSlideIn(
                    child: GradientCard(
                      colors: AppColors.primaryGradient,
                      onTap: () => context.go('/analyze'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHECK ANY ARTICLE',
                            style: AppTypography.eyebrow(
                              theme.colorScheme.onPrimary.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check any article for fake news',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Paste text or a headline, get a verdict backed by multiple AI models.',
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
                            onPressed: () => context.go('/analyze'),
                            child: const Text('Start a check  →'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent checks', style: theme.textTheme.titleLarge),
                      TextButton(
                        onPressed: () => context.push('/history'),
                        child: const Text('See all'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  historyAsync.when(
                    loading: () =>
                        const ShimmerListSkeleton(count: 3, itemHeight: 86),
                    error: (error, _) => ErrorView(error: error, compact: true),
                    data: (entries) {
                      if (entries.isEmpty) {
                        return const EmptyState(
                          icon: Icons.history_rounded,
                          title: 'No checks yet',
                          subtitle: 'Run a check to see it here.',
                        );
                      }
                      final preview = entries.take(6).toList();
                      return Column(
                        children: [
                          for (var i = 0; i < preview.length; i++)
                            RecentPredictionTile(
                              entry: preview[i],
                              showDivider: i != preview.length - 1,
                              onTap: () => context.push('/history'),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthDot extends StatelessWidget {
  const _HealthDot({required this.healthAsync});

  final AsyncValue<ServerHealth> healthAsync;

  @override
  Widget build(BuildContext context) {
    final color = healthAsync.maybeWhen(
      data: (h) => switch (h.status) {
        ServerHealthStatus.healthy => AppColors.success,
        ServerHealthStatus.degraded => AppColors.warning,
        ServerHealthStatus.unavailable => AppColors.error,
        ServerHealthStatus.unknown => AppColors.neutral400,
      },
      orElse: () => AppColors.neutral400,
    );
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
