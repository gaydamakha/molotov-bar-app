import 'package:molotov_bar/core/models/cocktail.dart';

abstract class CocktailRepository {
  Future<List<Cocktail>> getAll();

  Future<List<Cocktail>> search(String value);

  Future<List<Cocktail>> getFavorites();

  Cocktail setFavorite(Cocktail cocktail);

  Cocktail unsetFavorite(Cocktail cocktail);
}
