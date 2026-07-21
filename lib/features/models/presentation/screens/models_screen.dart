import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../providers/models_providers.dart';
import '../widgets/model_card.dart';

/// Lists every backend model with sorting, category filtering, "loaded
/// only" toggle and search.
class ModelsScreen extends ConsumerWidget {
  const ModelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filteredModelsProvider);
    final filter = ref.watch(modelsFilterProvider);
    final filterNotifier = ref.read(modelsFilterProvider.notifier);
    final allModelsAsync = ref.watch(modelsListProvider);

    final categories = allModelsAsync.maybeWhen(
      data: (models) => models.map((m) => m.category).toSet().toList()..sort(),
      orElse: () => <String>[],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Models')),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(modelsListProvider.future),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                onChanged: filterNotifier.setSearch,
                decoration: const InputDecoration(
                  hintText: 'Search models…',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: filter.category == null,
                    onSelected: (_) => filterNotifier.setCategory(null),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Loaded only'),
                    selected: filter.onlyLoaded,
                    onSelected: filterNotifier.toggleOnlyLoaded,
                  ),
                  const SizedBox(width: 8),
                  ...categories.map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: filter.category == category,
                        onSelected: (_) => filterNotifier.setCategory(category),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Sort by', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 8),
                  DropdownButton<ModelSortOption>(
                    value: filter.sortOption,
                    underline: const SizedBox(),
                    items: ModelSortOption.values
                        .map((o) => DropdownMenuItem(value: o, child: Text(o.label)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) filterNotifier.setSort(value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredAsync.when(
                loading: () => const ShimmerListSkeleton(count: 5, itemHeight: 190),
                error: (error, _) => ErrorView(
                  error: error,
                  onRetry: () => ref.invalidate(modelsListProvider),
                ),
                data: (models) {
                  if (models.isEmpty) {
                    return const EmptyState(
                      icon: Icons.psychology_alt_outlined,
                      title: 'No models match your filters',
                      subtitle: 'Try clearing search or category filters.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: models.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return FadeSlideIn(
                        delay: Duration(milliseconds: 40 * index),
                        child: ModelCard(model: models[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
