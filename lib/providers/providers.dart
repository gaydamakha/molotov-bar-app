import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/composite/composite_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_ingredient_repository.dart';
import 'package:molotov_bar/core/repositories/http/interceptors/cocktaildb_cache_interceptor.dart';
import 'package:molotov_bar/core/repositories/ingredient_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/view_models/favorite_cocktails_view_model.dart';

final cacheStoreProvider = Provider<CacheStore>((ref) {
  return MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
});

final dioProvider = Provider<Dio>((ref) {
  final cacheStore = ref.read(cacheStoreProvider);
  final Dio dio = Dio();
  ref.onDispose(dio.close);
  final cacheOptions = CacheOptions(
    store: cacheStore,
    policy: CachePolicy.forceCache,
    hitCacheOnErrorExcept: [],
    maxStale: const Duration(days: 7),
    priority: CachePriority.normal,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: false,
  );

  return dio..interceptors.add(CocktaildbCacheInterceptor(options: cacheOptions));
});

final ingredientRepositoryProvider = Provider.autoDispose<IngredientRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HttpIngredientRepository(dio);
});

final ingredientsProvider = FutureProvider.autoDispose<List<Ingredient>>((ref) async {
  final repository = ref.read(ingredientRepositoryProvider);

  return await repository.getAll();
});

final cocktailRepositoryProvider = Provider<CocktailRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CompositeCocktailRepository(HttpCocktailRepository(dio), LocalCocktailRepository());
});

final cocktailsViewModelProvider = StateNotifierProvider.autoDispose<CocktailsViewModel, CocktailsListState>((ref) {
  final repository = ref.read(cocktailRepositoryProvider);
  return CocktailsViewModel(repository);
});

final favoriteCocktailsViewModelProvider = StateNotifierProvider.autoDispose<FavoriteCocktailsViewModel, CocktailsListState>((ref) {
  final repository = ref.read(cocktailRepositoryProvider);
  return FavoriteCocktailsViewModel(repository);
});
