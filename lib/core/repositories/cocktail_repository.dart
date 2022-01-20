import 'package:molotov_bar/core/models/cocktail.dart';

abstract class CocktailRepository {
  Future<List<Cocktail>> getAll();

  Future<List<Cocktail>> search(String value);

  Future<List<Cocktail>> filterByIngredient(String value);

  Future<List<Cocktail>> getFavorites();

  Future<Cocktail?> getByName(String name);

  Future<Cocktail> setFavorite(Cocktail cocktail);

  Future<Cocktail> unsetFavorite(Cocktail cocktail);
}
