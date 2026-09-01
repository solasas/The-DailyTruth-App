import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Wraps [child] in a themed shimmer sweep, used for skeleton loading states
/// while data is being fetched.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton placeholder for a generic card (title + a couple of lines),
/// shown while home/models/leaderboard data is loading.
class ShimmerCardSkeleton extends StatelessWidget {
  const ShimmerCardSkeleton({super.key, this.height = 110});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: height),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Row(
            children: [
              const ShimmerBox(width: 40, height: 40, borderRadius: 12),
              const SizedBox(width: 12),
              Expanded(child: ShimmerBox(width: double.infinity)),
            ],
          ),
          const ShimmerBox(width: double.infinity, height: 12),
          ShimmerBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 12,
          ),
        ],
      ),
    );
  }
}

/// A vertical list of [ShimmerCardSkeleton]s.
class ShimmerListSkeleton extends StatelessWidget {
  const ShimmerListSkeleton({super.key, this.count = 4, this.itemHeight = 110});

  final int count;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    // shrinkWrap + NeverScrollableScrollPhysics lets this skeleton size to
    // its content, so it works both as a whole screen's body (bounded by the
    // Scaffold) and as one item embedded inside another scrollable (e.g. the
    // Home dashboard's outer ListView) without hitting an unbounded-height
    // viewport error.
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => ShimmerCardSkeleton(height: itemHeight),
    );
  }
}
