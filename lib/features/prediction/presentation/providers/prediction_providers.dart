import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/prediction_history_local_datasource.dart';
import '../../data/datasources/prediction_remote_datasource.dart';
import '../../data/repositories/prediction_history_repository_impl.dart';
import '../../data/repositories/prediction_repository_impl.dart';
import '../../domain/entities/all_models_prediction.dart';
import '../../domain/entities/prediction_history_entry.dart';
import '../../domain/entities/prediction_result.dart';
import '../../domain/repositories/prediction_history_repository.dart';
import '../../domain/repositories/prediction_repository.dart';

const _uuid = Uuid();

final predictionRemoteDataSourceProvider = Provider<PredictionRemoteDataSource>((ref) {
  return PredictionRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final predictionRepositoryProvider = Provider<PredictionRepository>((ref) {
  return PredictionRepositoryImpl(ref.watch(predictionRemoteDataSourceProvider));
});

final predictionHistoryLocalDataSourceProvider =
    Provider<PredictionHistoryLocalDataSource>((ref) {
      return PredictionHistoryLocalDataSourceImpl(
        ref.watch(predictionHistoryBoxProvider),
      );
    });

final predictionHistoryRepositoryProvider = Provider<PredictionHistoryRepository>((
  ref,
) {
  return PredictionHistoryRepositoryImpl(
    ref.watch(predictionHistoryLocalDataSourceProvider),
  );
});

/// All locally-stored prediction history, most recent first.
final predictionHistoryProvider = FutureProvider.autoDispose<List<PredictionHistoryEntry>>((
  ref,
) async {
  final repository = ref.watch(predictionHistoryRepositoryProvider);
  return repository.getHistory();
});

final historySearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final filteredPredictionHistoryProvider =
    Provider.autoDispose<AsyncValue<List<PredictionHistoryEntry>>>((ref) {
      final historyAsync = ref.watch(predictionHistoryProvider);
      final query = ref.watch(historySearchQueryProvider).toLowerCase();

      return historyAsync.whenData((entries) {
        if (query.isEmpty) return entries;
        return entries.where((e) => e.text.toLowerCase().contains(query)).toList();
      });
    });

/// Text currently in the Analyze screen's input field, kept in a provider so
/// character-count/validation logic lives in one place instead of being
/// duplicated across widgets.
final analyzeTextProvider = StateProvider.autoDispose<String>((ref) => '');

final analyzeTextValidProvider = Provider.autoDispose<bool>((ref) {
  final length = ref.watch(analyzeTextProvider).trim().length;
  return length >= AppConstants.minAnalysisLength && length <= AppConstants.maxAnalysisLength;
});

/// Currently selected model on the Analyze screen's dropdown.
final selectedModelProvider = StateProvider.autoDispose<String?>((ref) => null);

/// Runs a single-model prediction and persists it to history on success.
class SinglePredictionNotifier extends AutoDisposeAsyncNotifier<PredictionResult?> {
  @override
  Future<PredictionResult?> build() async => null;

  Future<void> analyze({required String text, required String modelName}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(predictionRepositoryProvider);
      final result = await repository.predict(text: text, modelName: modelName);

      await ref
          .read(predictionHistoryRepositoryProvider)
          .save(
            PredictionHistoryEntry(
              id: _uuid.v4(),
              text: text,
              timestamp: DateTime.now(),
              isAllModels: false,
              results: [result],
            ),
          );
      ref.invalidate(predictionHistoryProvider);
      return result;
    });
  }

  void reset() => state = const AsyncData(null);
}

final singlePredictionProvider =
    AsyncNotifierProvider.autoDispose<SinglePredictionNotifier, PredictionResult?>(
      SinglePredictionNotifier.new,
    );

/// Runs an all-models prediction and persists the consensus + breakdown to
/// history on success.
class AllModelsPredictionNotifier
    extends AutoDisposeAsyncNotifier<AllModelsPrediction?> {
  @override
  Future<AllModelsPrediction?> build() async => null;

  Future<void> analyzeAll({required String text}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(predictionRepositoryProvider);
      final result = await repository.predictAll(text: text);

      await ref
          .read(predictionHistoryRepositoryProvider)
          .save(
            PredictionHistoryEntry(
              id: _uuid.v4(),
              text: text,
              timestamp: DateTime.now(),
              isAllModels: true,
              results: result.results,
              consensusLabel: result.consensusLabel,
              consensusConfidence: result.consensusConfidence,
            ),
          );
      ref.invalidate(predictionHistoryProvider);
      return result;
    });
  }

  void reset() => state = const AsyncData(null);
}

final allModelsPredictionProvider = AsyncNotifierProvider.autoDispose<
  AllModelsPredictionNotifier,
  AllModelsPrediction?
>(AllModelsPredictionNotifier.new);

enum ResultVerdictFilter { all, onlyFake, onlyReal }

class AllModelsFilterState {
  const AllModelsFilterState({
    this.search = '',
    this.verdictFilter = ResultVerdictFilter.all,
    this.category,
  });

  final String search;
  final ResultVerdictFilter verdictFilter;
  final String? category;

  AllModelsFilterState copyWith({
    String? search,
    ResultVerdictFilter? verdictFilter,
    String? category,
    bool clearCategory = false,
  }) {
    return AllModelsFilterState(
      search: search ?? this.search,
      verdictFilter: verdictFilter ?? this.verdictFilter,
      category: clearCategory ? null : (category ?? this.category),
    );
  }
}

class AllModelsFilterNotifier extends AutoDisposeNotifier<AllModelsFilterState> {
  @override
  AllModelsFilterState build() => const AllModelsFilterState();

  void setSearch(String value) => state = state.copyWith(search: value);

  void setVerdictFilter(ResultVerdictFilter filter) =>
      state = state.copyWith(verdictFilter: filter);

  void setCategory(String? category) {
    state = category == null
        ? state.copyWith(clearCategory: true)
        : state.copyWith(category: category);
  }
}

final allModelsFilterProvider =
    AutoDisposeNotifierProvider<AllModelsFilterNotifier, AllModelsFilterState>(
      AllModelsFilterNotifier.new,
    );

/// Applies [allModelsFilterProvider] on top of the current
/// [allModelsPredictionProvider] results list.
final filteredAllModelsResultsProvider = Provider.autoDispose<List<PredictionResult>>((
  ref,
) {
  final prediction = ref.watch(allModelsPredictionProvider).valueOrNull;
  if (prediction == null) return const [];

  final filter = ref.watch(allModelsFilterProvider);

  return prediction.results.where((result) {
    final matchesSearch =
        filter.search.isEmpty ||
        result.displayName.toLowerCase().contains(filter.search.toLowerCase()) ||
        result.modelName.toLowerCase().contains(filter.search.toLowerCase());
    final matchesVerdict = switch (filter.verdictFilter) {
      ResultVerdictFilter.all => true,
      ResultVerdictFilter.onlyFake => result.label == PredictionLabel.fake,
      ResultVerdictFilter.onlyReal => result.label == PredictionLabel.real,
    };
    final matchesCategory = filter.category == null || result.category == filter.category;
    return matchesSearch && matchesVerdict && matchesCategory;
  }).toList();
});
