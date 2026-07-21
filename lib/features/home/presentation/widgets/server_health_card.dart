import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../domain/entities/server_health.dart';

/// Green/orange/red status card summarizing backend health, shown at the
/// top of the dashboard.
class ServerHealthCard extends StatelessWidget {
  const ServerHealthCard({super.key, required this.health});

  final ServerHealth health;

  Color get _color => switch (health.status) {
    ServerHealthStatus.healthy => AppColors.success,
    ServerHealthStatus.degraded => AppColors.warning,
    ServerHealthStatus.unavailable => AppColors.error,
    ServerHealthStatus.unknown => AppColors.textSecondaryLight,
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
    return SoftCard(
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: _color.withValues(alpha: 0.14), shape: BoxShape.circle),
            child: Icon(_icon, color: _color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Server Status', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
                    ),
                  ],
                ),
                Text(
                  _label,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: _color, fontWeight: FontWeight.w700),
                ),
                Text(
                  '${health.modelsLoaded}${health.totalModels != null ? '/${health.totalModels}' : ''} models loaded',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
