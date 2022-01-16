import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';

class CocktailsViewModel extends StateNotifier<CocktailsListState> {
  CocktailsViewModel(this._cocktailRepository)
      : super(const CocktailsListState()) {
    initCocktailsList();
  }

  final CocktailRepository _cocktailRepository;

  CocktailError? getError() => state.error;

  bool isLoading() => state.isLoading;

  List<Cocktail> getCocktails() => state.cocktails.values.toList();

  List<Cocktail> getFavorites() => state.cocktails.values.where((c) => c.favorite).toList();

  _setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  _setCocktails(List<Cocktail> cocktailsList) {
    state = state.copyWith(cocktails: {for (var c in cocktailsList) c.name: c});
  }

  _setError(CocktailError cocktailError) {
    state = state.copyWith(error: cocktailError);
  }

  /// Call the cocktail repository and gets the data of requested cocktails f
  /// an artist.
  Future<void> searchCocktails(String value) async {
    _setLoading(true);
    try {
      final cocktails = await _cocktailRepository.getAll();
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }

  Future<void> setCocktailFavorite(Cocktail cocktail) async {
    state.cocktails[cocktail.name] =
        await _cocktailRepository.setFavorite(cocktail);
  }

  Future<void> unsetCocktailFavorite(Cocktail cocktail) async {
    state.cocktails[cocktail.name] =
        await _cocktailRepository.unsetFavorite(cocktail);
  }

  Future<void> initCocktailsList() async {
    try {
      final cocktails = await _cocktailRepository.getAll();
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }
}
