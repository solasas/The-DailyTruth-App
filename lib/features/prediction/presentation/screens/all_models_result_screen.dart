import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../providers/prediction_providers.dart';
import '../widgets/consensus_card.dart';
import '../widgets/expandable_prediction_card.dart';

/// Displays the consensus verdict plus every individual model's result from
/// `POST /predict/all`, with search + verdict/category filters.
class AllModelsResultScreen extends ConsumerWidget {
  const AllModelsResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allModelsPredictionProvider);
    final filter = ref.watch(allModelsFilterProvider);
    final filterNotifier = ref.read(allModelsFilterProvider.notifier);
    final filteredResults = ref.watch(filteredAllModelsResultsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Model Analysis')),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(error: error),
        data: (prediction) {
          if (prediction == null) {
            return const ErrorView(error: 'No result available.');
          }

          final categories = prediction.results.map((r) => r.category).toSet().toList()..sort();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              FadeSlideIn(
                child: ConsensusCard(
                  label: prediction.consensusLabel,
                  confidence: prediction.consensusConfidence,
                  modelCount: prediction.results.length,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: filterNotifier.setSearch,
                decoration: const InputDecoration(
                  hintText: 'Search model…',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: filter.verdictFilter == ResultVerdictFilter.all,
                      onSelected: (_) => filterNotifier.setVerdictFilter(ResultVerdictFilter.all),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Only Fake'),
                      selected: filter.verdictFilter == ResultVerdictFilter.onlyFake,
                      onSelected: (_) =>
                          filterNotifier.setVerdictFilter(ResultVerdictFilter.onlyFake),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Only Real'),
                      selected: filter.verdictFilter == ResultVerdictFilter.onlyReal,
                      onSelected: (_) =>
                          filterNotifier.setVerdictFilter(ResultVerdictFilter.onlyReal),
                    ),
                    const SizedBox(width: 8),
                    ...categories.map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: filter.category == category,
                          onSelected: (_) => filterNotifier.setCategory(
                            filter.category == category ? null : category,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (filteredResults.isEmpty)
                const EmptyState(
                  icon: Icons.filter_alt_off_rounded,
                  title: 'No models match your filters',
                )
              else
                ...filteredResults.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FadeSlideIn(
                      delay: Duration(milliseconds: 30 * entry.key),
                      child: ExpandablePredictionCard(result: entry.value),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
