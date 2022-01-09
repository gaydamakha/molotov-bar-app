import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';

class FavoriteCocktailsViewModel extends ChangeNotifier {
  bool _loading = false;
  Map<String, Cocktail> _cocktails = {};
  CocktailError? _cocktailError;

  bool get loading => _loading;

  List<Cocktail> getCocktails() {
    return _cocktails.values.toList();
  }

  CocktailError? get cocktailError => _cocktailError;

  final CocktailRepository _cocktailRepository =
      GetIt.instance<CocktailRepository>();

  FavoriteCocktailsViewModel() {
    initCocktailsList();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCocktails(List<Cocktail> cocktailsList) {
    _cocktails = {for (var c in cocktailsList) c.name: c};
  }

  setCocktailError(CocktailError cocktailError) {
    _cocktailError = cocktailError;
  }

  refresh() async {
    setLoading(true);
    var response = await _cocktailRepository.getFavorites();
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

  initCocktailsList() async {
    refresh();
  }
}
