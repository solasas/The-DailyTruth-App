import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/brand_app_bar.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/login_sheet.dart';
import '../../../prediction/presentation/providers/prediction_providers.dart';
import '../../../prediction/presentation/widgets/recent_prediction_tile.dart';
import '../../domain/entities/server_health.dart';
import '../providers/home_providers.dart';
import '../widgets/app_footer.dart';

/// Landing screen, laid out like the reference front page: a "LIVE" feature
/// card into the check flow, two side stories (Paper Trail, leaderboard), an
/// "Explore more" rail of tools, the device's recent checks, and the footer.
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

  /// Opens the Check tab with [mode] pre-selected.
  void _openCheck(BuildContext context, WidgetRef ref, CheckMode mode) {
    ref.read(checkModeProvider.notifier).state = mode;
    context.go('/analyze');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(predictionHistoryProvider);
    final healthAsync = ref.watch(serverHealthProvider);
    final isAuthed = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      appBar: BrandAppBar(
        actions: [
          _HealthDot(healthAsync: healthAsync),
          const SizedBox(width: 12),
          CircleIconButton(
            tooltip: isAuthed ? 'Profile' : 'Sign in',
            icon: isAuthed
                ? Icons.person_rounded
                : Icons.person_outline_rounded,
            onPressed: () =>
                isAuthed ? context.go('/profile') : LoginSheet.show(context),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(ref),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FadeSlideIn(
                          child: _FeatureCard(
                            onTap: () =>
                                _openCheck(context, ref, CheckMode.single),
                          ),
                        ),
                        const SizedBox(height: 14),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 80),
                          child: _SideStory(
                            icon: Icons.description_outlined,
                            title:
                                'Paper Trail: evidence-grounded verification, '
                                'claim by claim',
                            meta:
                                'Agentic fact-check · '
                                'Up to ${AppConstants.maxClaims} claims',
                            onTap: () => context.go('/verify'),
                          ),
                        ),
                        const SizedBox(height: 14),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 160),
                          child: _SideStory(
                            icon: Icons.leaderboard_outlined,
                            title:
                                'Which model spots fake news best? See the '
                                'benchmark leaderboard',
                            meta: 'Benchmark rankings · Accuracy, F1, AUC',
                            onTap: () => context.go('/models'),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const SectionHeader(title: 'Explore more'),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 196,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _ExploreCard(
                          icon: Icons.verified_outlined,
                          tag: 'Check',
                          title: 'Single article verification',
                          onTap: () =>
                              _openCheck(context, ref, CheckMode.single),
                        ),
                        _ExploreCard(
                          icon: Icons.hub_outlined,
                          tag: 'Panel',
                          title: 'Editorial consensus',
                          onTap: () =>
                              _openCheck(context, ref, CheckMode.consensus),
                        ),
                        _ExploreCard(
                          icon: Icons.view_list_rounded,
                          tag: 'Bulk',
                          title: 'Batch analysis',
                          onTap: () =>
                              _openCheck(context, ref, CheckMode.batch),
                        ),
                        _ExploreCard(
                          icon: Icons.bar_chart_rounded,
                          tag: 'Charts',
                          title: 'Benchmark charts',
                          onTap: () => context.push('/charts'),
                        ),
                        _ExploreCard(
                          icon: Icons.history_rounded,
                          tag: 'Archive',
                          title: 'Your check history',
                          onTap: () => context.push('/history'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SectionHeader(
                          title: 'Recent checks',
                          action: TextButton(
                            onPressed: () => context.push('/history'),
                            child: const Text('See all'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        historyAsync.when(
                          loading: () => const ShimmerListSkeleton(
                            count: 3,
                            itemHeight: 86,
                          ),
                          error: (error, _) =>
                              ErrorView(error: error, compact: true),
                          data: (entries) {
                            if (entries.isEmpty) {
                              return const EmptyState(
                                icon: Icons.history_rounded,
                                title: 'No checks yet',
                                subtitle: 'Run a check to see it here.',
                              );
                            }
                            final preview = entries.take(6).toList();
                            return SoftCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 2,
                              ),
                              child: Column(
                                children: [
                                  for (var i = 0; i < preview.length; i++)
                                    RecentPredictionTile(
                                      entry: preview[i],
                                      showDivider: i != preview.length - 1,
                                      onTap: () => context.push('/history'),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The reference's lead story: always-dark card with a "● LIVE" tag, a
/// tracked source line, a heavy upper-case headline and a red "read" link.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderDark),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF3A0B07), Color(0xFF161616), Color(0xFF0B0B0B)],
              stops: [0, 0.55, 1],
            ),
          ),
          child: Stack(
            children: [
              // Oversized watermark glyph standing in for the lead photo.
              Positioned(
                right: -24,
                top: -12,
                child: Icon(
                  Icons.newspaper_rounded,
                  size: 170,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Tag(label: '● Live', color: AppColors.primary),
                    const SizedBox(height: 48),
                    Text(
                      'THE DAILY TRUTH · AI DESK',
                      style: AppTypography.eyebrow(
                        Colors.white.withValues(alpha: 0.8),
                      ).copyWith(letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CHECK ANY ARTICLE FOR FAKE NEWS IN SECONDS',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Paste text or a headline and get a verdict backed by '
                      'multiple AI models.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Start a check →',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.accent300,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Right-column story row: square thumbnail + bold two-line title + tracked
/// meta line.
class _SideStory extends StatelessWidget {
  const _SideStory({
    required this.icon,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _Thumb(icon: icon, size: 64),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  meta.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6,
                    color: theme.extension<AppSemanticColors>()?.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "Explore more" rail card: image-slot tile with a red tag, title below.
class _ExploreCard extends StatelessWidget {
  const _ExploreCard({
    required this.icon,
    required this.tag,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String tag;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 160,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _Thumb(icon: icon, size: 160, height: 128),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: _Tag(label: tag, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dark image-slot placeholder with a centered glyph.
class _Thumb extends StatelessWidget {
  const _Thumb({required this.icon, required this.size, this.height});

  final IconData icon;
  final double size;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: height ?? size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDark),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A2A), Color(0xFF121212)],
        ),
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
        size: (height ?? size) * 0.34,
      ),
    );
  }
}

/// Tiny solid red label ("LIVE", "NEWS").
class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _HealthDot extends StatelessWidget {
  const _HealthDot({required this.healthAsync});

  final AsyncValue<ServerHealth> healthAsync;

  @override
  Widget build(BuildContext context) {
    final (color, label) = healthAsync.maybeWhen(
      data: (h) => switch (h.status) {
        ServerHealthStatus.healthy => (AppColors.success, 'Server healthy'),
        ServerHealthStatus.degraded => (AppColors.warning, 'Server degraded'),
        ServerHealthStatus.unavailable => (
          AppColors.error,
          'Server unavailable',
        ),
        ServerHealthStatus.unknown => (AppColors.neutral400, 'Server unknown'),
      },
      orElse: () => (AppColors.neutral400, 'Checking server…'),
    );
    return Tooltip(
      message: label,
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
