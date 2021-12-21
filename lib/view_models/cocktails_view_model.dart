import 'package:flutter/foundation.dart';
import 'package:molotov_bar/core/model_data.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';

class CocktailsViewModel with ChangeNotifier {
  ModelData _modelData = ModelData.initial('Empty data');

  CocktailRepository cocktailRepository = HttpCocktailRepository(); //todo put somewhere in DI

  Cocktail? _cocktail;

  ModelData get modelData {
    return _modelData;
  }

  Cocktail? get cocktail {
    return _cocktail;
  }

  /// Call the cocktail repository and gets the data of requested cocktails f
  /// an artist.
  Future<void> fetchCocktailsData(String value) async {
    _modelData = ModelData.loading('Fetching artist data');
    notifyListeners();
    try {
      List<Cocktail> cocktails = await cocktailRepository.getAll();
      _modelData = ModelData.completed(cocktails);
    } catch (e) {
      _modelData = ModelData.error(e.toString());
    }
    notifyListeners();
  }

  void setSelectedCocktail(Cocktail? cocktail) {
    _cocktail = cocktail;
    notifyListeners();
  }
}
