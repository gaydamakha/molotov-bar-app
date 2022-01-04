import 'package:molotov_bar/core/models/cocktail.dart';

abstract class FavoriteCocktailRepository {
  Future<List<Cocktail>> getFavorites();
}
