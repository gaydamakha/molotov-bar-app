import 'package:molotov_bar/core/models/cocktail.dart';

abstract class CocktailRepository {
  Future<List<Cocktail>> getAll(int limit, {int offset = 0});

  Future<List<Cocktail>> search(String value, int limit, {int offset = 0});

  Future<List<Cocktail>> filterByIngredient(String value, int limit, {int offset = 0});

  Future<List<Cocktail>> getFavorites(int limit, {int offset = 0});

  Future<Cocktail?> getById(int id);

  Future<Cocktail> setFavorite(Cocktail cocktail);

  Future<Cocktail> unsetFavorite(Cocktail cocktail);
}
