import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/composite/composite_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_ingredient_repository.dart';
import 'package:molotov_bar/core/repositories/ingredient_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/view_models/favorite_cocktails_view_model.dart';

final ingredientRepositoryProvider = Provider.autoDispose<IngredientRepository>((ref) {
  return HttpIngredientRepository();
});

final ingredientsProvider = FutureProvider.autoDispose<List<Ingredient>>((ref) async {
  final repository = ref.read(ingredientRepositoryProvider);

  return await repository.getAll();
});

final cocktailRepositoryProvider = Provider.autoDispose<CocktailRepository>((ref) {
  return CompositeCocktailRepository(HttpCocktailRepository(), LocalCocktailRepository());
});

final cocktailsViewModelProvider = StateNotifierProvider.autoDispose<CocktailsViewModel, CocktailsListState>((ref) {
  final repository = ref.read(cocktailRepositoryProvider);
  return CocktailsViewModel(repository);
});

final favoriteCocktailsViewModelProvider = StateNotifierProvider.autoDispose<FavoriteCocktailsViewModel, CocktailsListState>((ref) {
  final repository = ref.read(cocktailRepositoryProvider);
  return FavoriteCocktailsViewModel(repository);
});
