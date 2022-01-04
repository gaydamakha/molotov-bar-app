import 'package:flutter/foundation.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/favorite_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';

class FavoriteCocktailsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Cocktail> _cocktailsFavoriteList = [];
  CocktailError? _cocktailError;
  final FavoriteCocktailRepository _favoriteCocktailRepository =
      LocalFavoriteCocktailRepository(); //todo put somewhere in DI

  bool get loading => _loading;

  List<Cocktail> get cocktailsFavoriteList => _cocktailsFavoriteList;

  CocktailError? get cocktailError => _cocktailError;

  FavoriteCocktailsViewModel() {
    initCocktailsList();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCocktailsFavoriteList(List<Cocktail> cocktailsList) {
    _cocktailsFavoriteList = cocktailsList;
  }

  setCocktailError(CocktailError cocktailError) {
    _cocktailError = cocktailError;
  }

  initCocktailsList() async {
    setLoading(true);
    var response = await _favoriteCocktailRepository.getFavorites();
    try {
      setCocktailsFavoriteList(response);
    } on Exception {
      var error = CocktailError(
        code: 111,
        message: 'error',
      );
      setCocktailError(error);
    }
    setLoading(false);
  }
}
