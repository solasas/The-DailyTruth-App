import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../domain/entities/server_health.dart';

/// Gradient hero card summarizing backend health — green/orange/red per
/// [ServerHealthStatus] — shown at the top of the dashboard.
class ServerHealthCard extends StatelessWidget {
  const ServerHealthCard({super.key, required this.health});

  final ServerHealth health;

  List<Color> get _gradient => switch (health.status) {
    ServerHealthStatus.healthy => AppColors.successGradient,
    ServerHealthStatus.degraded => AppColors.warningGradient,
    ServerHealthStatus.unavailable => AppColors.errorGradient,
    ServerHealthStatus.unknown => [
      AppColors.textSecondaryLight,
      AppColors.textSecondaryDark,
    ],
  };

  String get _label => switch (health.status) {
    ServerHealthStatus.healthy => 'Healthy',
    ServerHealthStatus.degraded => 'Degraded',
    ServerHealthStatus.unavailable => 'Unavailable',
    ServerHealthStatus.unknown => 'Unknown',
  };

  IconData get _icon => switch (health.status) {
    ServerHealthStatus.healthy => Icons.check_circle_rounded,
    ServerHealthStatus.degraded => Icons.warning_rounded,
    ServerHealthStatus.unavailable => Icons.error_rounded,
    ServerHealthStatus.unknown => Icons.help_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      colors: _gradient,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SERVER STATUS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${health.modelsLoaded}${health.totalModels != null ? '/${health.totalModels}' : ''} models loaded',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
