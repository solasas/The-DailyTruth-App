import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/models_remote_datasource.dart';
import '../../data/repositories/models_repository_impl.dart';
import '../../domain/entities/model_info.dart';
import '../../domain/entities/model_registry_entry.dart';
import '../../domain/repositories/models_repository.dart';

final modelsRemoteDataSourceProvider = Provider<ModelsRemoteDataSource>((ref) {
  return ModelsRemoteDataSourceImpl(ref.watch(dioClientProvider));
});

final modelsRepositoryProvider = Provider<ModelsRepository>((ref) {
  return ModelsRepositoryImpl(ref.watch(modelsRemoteDataSourceProvider));
});

/// Fetches every model from the backend. Screens call `.refresh()` /
/// `ref.invalidate` on this for pull-to-refresh.
final modelsListProvider = FutureProvider.autoDispose<List<ModelInfo>>((
  ref,
) async {
  final repository = ref.watch(modelsRepositoryProvider);
  return repository.getModels();
});

/// Convenience provider that only returns models the backend reports as
/// `loaded`, used to populate the Analyze screen's model dropdown.
final loadedModelsProvider = FutureProvider.autoDispose<List<ModelInfo>>((
  ref,
) async {
  final models = await ref.watch(modelsListProvider.future);
  return models.where((m) => m.loaded).toList();
});

/// Full `GET /models/registry` payload — training metrics + chart artefacts
/// per model. Backs the Model Registry screen.
final modelRegistryProvider = FutureProvider.autoDispose<ModelRegistry>((
  ref,
) async {
  return ref.watch(modelsRepositoryProvider).getRegistry();
});

enum ModelSortOption { accuracyDesc, nameAsc, categoryAsc }

extension ModelSortOptionLabel on ModelSortOption {
  String get label => switch (this) {
    ModelSortOption.accuracyDesc => 'Accuracy',
    ModelSortOption.nameAsc => 'Name',
    ModelSortOption.categoryAsc => 'Category',
  };
}

class ModelsFilterState {
  const ModelsFilterState({
    this.search = '',
    this.category,
    this.onlyLoaded = false,
    this.sortOption = ModelSortOption.accuracyDesc,
  });

  final String search;
  final String? category;
  final bool onlyLoaded;
  final ModelSortOption sortOption;

  ModelsFilterState copyWith({
    String? search,
    String? category,
    bool clearCategory = false,
    bool? onlyLoaded,
    ModelSortOption? sortOption,
  }) {
    return ModelsFilterState(
      search: search ?? this.search,
      category: clearCategory ? null : (category ?? this.category),
      onlyLoaded: onlyLoaded ?? this.onlyLoaded,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

class ModelsFilterNotifier extends Notifier<ModelsFilterState> {
  @override
  ModelsFilterState build() => const ModelsFilterState();

  void setSearch(String value) => state = state.copyWith(search: value);

  void setCategory(String? category) {
    state = category == null
        ? state.copyWith(clearCategory: true)
        : state.copyWith(category: category);
  }

  void toggleOnlyLoaded(bool value) =>
      state = state.copyWith(onlyLoaded: value);

  void setSort(ModelSortOption option) =>
      state = state.copyWith(sortOption: option);
}

final modelsFilterProvider =
    NotifierProvider<ModelsFilterNotifier, ModelsFilterState>(
      ModelsFilterNotifier.new,
    );

/// Applies the current [ModelsFilterState] to the raw model list — combined
/// here so the screen only ever renders one derived, ready-to-display list.
final filteredModelsProvider =
    Provider.autoDispose<AsyncValue<List<ModelInfo>>>((ref) {
      final modelsAsync = ref.watch(modelsListProvider);
      final filter = ref.watch(modelsFilterProvider);

      return modelsAsync.whenData((models) {
        var result = models.where((model) {
          final matchesSearch =
              filter.search.isEmpty ||
              model.displayName.toLowerCase().contains(
                filter.search.toLowerCase(),
              ) ||
              model.name.toLowerCase().contains(filter.search.toLowerCase());
          final matchesCategory =
              filter.category == null || model.category == filter.category;
          final matchesLoaded = !filter.onlyLoaded || model.loaded;
          return matchesSearch && matchesCategory && matchesLoaded;
        }).toList();

        result.sort((a, b) {
          switch (filter.sortOption) {
            case ModelSortOption.accuracyDesc:
              return b.accuracy.compareTo(a.accuracy);
            case ModelSortOption.nameAsc:
              return a.displayName.toLowerCase().compareTo(
                b.displayName.toLowerCase(),
              );
            case ModelSortOption.categoryAsc:
              return a.category.toLowerCase().compareTo(
                b.category.toLowerCase(),
              );
          }
        });
        return result;
      });
    });
