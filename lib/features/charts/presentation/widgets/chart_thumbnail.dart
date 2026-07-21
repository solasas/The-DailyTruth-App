import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/chart_info.dart';
import '../providers/charts_providers.dart';

/// Grid tile that lazily loads a chart's bytes and opens the fullscreen
/// viewer on tap, sharing a [Hero] tag with it for a smooth transition.
class ChartThumbnail extends ConsumerWidget {
  const ChartThumbnail({super.key, required this.chart, required this.onTap});

  final ChartInfo chart;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(chartImageProvider(chart.name));

    return Material(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'chart-${chart.name}',
                child: imageAsync.when(
                  loading: () => const ShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 0),
                  error: (_, __) => const Center(child: Icon(Icons.broken_image_outlined)),
                  data: (bytes) => Image.memory(bytes, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                chart.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
