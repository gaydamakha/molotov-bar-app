import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';

class CocktailsViewModel extends StateNotifier<CocktailsListState> {
  final int defaultLimit = 100;

  CocktailsViewModel(this._cocktailRepository)
      : super(const CocktailsListState()) {
    initCocktailsList();
  }

  String? ingredient;

  final CocktailRepository _cocktailRepository;

  CocktailError? getError() => state.error;

  bool isLoading() => state.isLoading;

  List<Cocktail> getCocktails() => state.cocktails.values.toList();

  _setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  _setCocktails(List<Cocktail> cocktailsList) {
    state = state.copyWith(cocktails: {for (var c in cocktailsList) c.id: c});
  }

  _setError(CocktailError cocktailError) {
    state = state.copyWith(error: cocktailError);
  }

  Future<void> searchCocktails(String value) async {
    _setLoading(true);
    try {
      final cocktails = await _cocktailRepository.search(value, defaultLimit);
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }

  Future<void> filterByIngredient(String value) async {
    _setLoading(true);
    try {
      final cocktails = await _cocktailRepository.filterByIngredient(value, defaultLimit);
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }

  Future<void> initCocktailsList() async {
    try {
      final cocktails = await _cocktailRepository.getAll(defaultLimit);
      _setCocktails(cocktails);
    } on CocktailError catch (e) {
      _setError(e);
    }
    _setLoading(false);
  }
}
