import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';

class FavoriteCocktailsViewModel extends StateNotifier<CocktailsListState> {
  FavoriteCocktailsViewModel(this._cocktailRepository)
      : super(const CocktailsListState()) {
    initCocktailsList();
  }

  final CocktailRepository _cocktailRepository;

  CocktailError? getError() => state.error;

  bool isLoading() => state.isLoading;

  List<Cocktail> getCocktails() => state.cocktails.values.toList();

  _setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  _setCocktails(List<Cocktail> cocktailsList) {
    state = state.copyWith(cocktails: {for (var c in cocktailsList) c.name: c});
  }

  _setError(CocktailError cocktailError) {
    state = state.copyWith(error: cocktailError);
  }

  Future<Cocktail?> getByName(String name) async {
    return await _cocktailRepository.getByName(name);
  }

  Future<Cocktail> setCocktailFavorite(Cocktail cocktail) async {
    final ctl = await _cocktailRepository.setFavorite(cocktail);
    final cocktails = state.cocktails;
    cocktails[ctl.name] = ctl;
    state = state.copyWith(cocktails: cocktails);
    return ctl;
  }

  Future<void> unsetCocktailFavorite(Cocktail cocktail) async {
    final ctl = await _cocktailRepository.unsetFavorite(cocktail);
    final cocktails = state.cocktails;
    cocktails.remove(ctl.name);
    state = state.copyWith(cocktails: cocktails);
    return;
  }

  Future<void> initCocktailsList() async {
    try {
      final cocktails = await _cocktailRepository.getFavorites();
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }
}
