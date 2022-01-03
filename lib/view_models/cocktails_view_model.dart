import 'package:flutter/foundation.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';

class CocktailsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Cocktail> _cocktailsList = [];
  CocktailError? _cocktailError;

  bool get loading => _loading;

  List<Cocktail> get cocktailsList => _cocktailsList;

  CocktailError? get cocktailError => _cocktailError;

  final CocktailRepository _cocktailRepository = HttpCocktailRepository(); //todo put somewhere in DI

  CocktailsViewModel() {
    initCocktailsList();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCocktailsList(List<Cocktail> cocktailsList) {
    _cocktailsList = cocktailsList;
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
      setCocktailsList(response);
    } on Exception {
      var error = CocktailError(
        code: 111,
        message: 'error',
      );
      setCocktailError(error);
    }
    setLoading(false);
  }

  // void setSelectedCocktail(Cocktail? cocktail) {
  //   _cocktail = cocktail;
  //   notifyListeners();
  // }

  initCocktailsList() async {
    setLoading(true);
    var response = await _cocktailRepository.getAll();
    try {
      setCocktailsList(response);
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
