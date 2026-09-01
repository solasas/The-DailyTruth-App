import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../auth/domain/entities/auth_session.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/presentation/widgets/sign_in_required.dart';
import '../../domain/entities/review_queue_item.dart';
import '../providers/review_providers.dart';
import '../widgets/resolve_review_sheet.dart';
import '../widgets/review_queue_tile.dart';

/// Paginated analyst review queue. Reading is open; resolving requires an
/// analyst/admin bearer token.
class ReviewQueueScreen extends ConsumerStatefulWidget {
  const ReviewQueueScreen({super.key});

  @override
  ConsumerState<ReviewQueueScreen> createState() => _ReviewQueueScreenState();
}

class _ReviewQueueScreenState extends ConsumerState<ReviewQueueScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      ref.read(reviewQueueControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(reviewQueueControllerProvider);
    final filter = ref.watch(reviewStatusFilterProvider);
    final role = ref.watch(currentRoleProvider);
    final canResolve = role != null && role.canResolveReviews;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review queue'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Center(
                  child: _FilterChip(
                    label: 'All',
                    selected: filter == null,
                    onSelected: () =>
                        ref.read(reviewStatusFilterProvider.notifier).state =
                            null,
                  ),
                ),
                for (final s in ReviewStatus.values)
                  Center(
                    child: _FilterChip(
                      label: s.label,
                      selected: filter == s,
                      onSelected: () =>
                          ref.read(reviewStatusFilterProvider.notifier).state =
                              s,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(reviewQueueControllerProvider.notifier).refresh(),
        child: async.when(
          loading: () => const ShimmerListSkeleton(count: 5, itemHeight: 150),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 80),
              ErrorView(
                error: error,
                onRetry: () =>
                    ref.read(reviewQueueControllerProvider.notifier).refresh(),
              ),
            ],
          ),
          data: (state) {
            if (state.items.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 80),
                  EmptyState(
                    icon: Icons.inbox_rounded,
                    title: 'Queue is clear',
                    subtitle: 'Nothing is waiting for analyst review.',
                  ),
                ],
              );
            }
            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: state.items.length + 1,
              itemBuilder: (context, index) {
                if (index == state.items.length) {
                  if (!state.hasMore) return const SizedBox(height: 8);
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = state.items[index];
                return ReviewQueueTile(
                  item: item,
                  onResolve: () {
                    if (!canResolve) {
                      _promptSignIn(context);
                      return;
                    }
                    ResolveReviewSheet.show(context, item);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _promptSignIn(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: SignInRequired(
          message: 'Resolving items requires an analyst or admin account.',
          redirectTo: '/review-queue',
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
