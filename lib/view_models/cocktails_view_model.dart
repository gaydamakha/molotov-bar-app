import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';

class CocktailsViewModel extends ChangeNotifier {
  bool _loading = false;
  Map<String, Cocktail> _cocktails = {};
  CocktailError? _cocktailError;

  bool get loading => _loading;

  List<Cocktail> getCocktails() => _cocktails.values.toList();

  CocktailError? get cocktailError => _cocktailError;

  final CocktailRepository _cocktailRepository =
      GetIt.instance<CocktailRepository>();

  CocktailsViewModel() {
    initCocktailsList();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCocktails(List<Cocktail> cocktailsList) {
    _cocktails = { for (var c in cocktailsList) c.name : c };
  }

  setCocktailError(CocktailError cocktailError) {
    _cocktailError = cocktailError;
  }

  /// Call the cocktail repository and gets the data of requested cocktails f
  /// an artist.
  Future<void> searchCocktails(String value) async {
    setLoading(true);
    var response = await _cocktailRepository.search(value);
    try {
      setCocktails(response);
    } on Exception {
      var error = CocktailError(
        code: 111,
        message: 'error',
      );
      setCocktailError(error);
    }
    setLoading(false);
  }

  void setCocktailFavorite(Cocktail cocktail) {
    _cocktails[cocktail.name] = _cocktailRepository.setFavorite(cocktail);
    notifyListeners();
  }

  void unsetCocktailFavorite(Cocktail cocktail) {
    _cocktails[cocktail.name] = _cocktailRepository.unsetFavorite(cocktail);
    notifyListeners();
  }

  initCocktailsList() async {
    setLoading(true);
    try {
      var response = await _cocktailRepository.getAll(); //todo return a subset (p.e. popular cocktails)
      setCocktails(response);
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
