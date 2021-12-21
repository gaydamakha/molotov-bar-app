import 'package:molotov_bar/core/models/cocktail.dart';

abstract class CocktailRepository {
  Future<List<Cocktail>> getAll();
}
