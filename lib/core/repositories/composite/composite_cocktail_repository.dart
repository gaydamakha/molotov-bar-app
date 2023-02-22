import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';

class CompositeCocktailRepository implements CocktailRepository {
  final CocktailRepository httpCocktailRepository;
  final LocalCocktailRepository localCocktailRepository;

  CompositeCocktailRepository(this.httpCocktailRepository, this.localCocktailRepository);

  @override
  Future<List<Cocktail>> getAll(int limit, {int offset = 0}) async {
    var cocktails = await httpCocktailRepository.getAll(limit, offset: offset);
    List<Cocktail> updatedCocktails = [];
    for (var cocktail in cocktails) {
      Cocktail? favoriteCocktail = await localCocktailRepository.getById(cocktail.id);
      if (favoriteCocktail != null) {
        cocktail.favorite = true;
      }
      updatedCocktails.add(cocktail);
    }
    return updatedCocktails;
  }

  @override
  Future<List<Cocktail>> getFavorites(int limit, {int offset = 0}) {
    return localCocktailRepository.getFavorites(limit, offset: offset);
  }

  @override
  Future<List<Cocktail>> search(String value, int limit, {int offset = 0}) async {
    var cocktails = await httpCocktailRepository.search(value, limit, offset: offset);
    List<Cocktail> updatedCocktails = [];
    for (var cocktail in cocktails) {
      Cocktail? favoriteCocktail = await localCocktailRepository.getById(cocktail.id);
      if (favoriteCocktail != null) {
        cocktail.favorite = true;
      }
      updatedCocktails.add(cocktail);
    }
    return updatedCocktails;
  }

  @override
  Future<Cocktail> setFavorite(Cocktail cocktail) async {
    return localCocktailRepository.setFavorite(cocktail);
  }

  @override
  Future<Cocktail> unsetFavorite(Cocktail cocktail) async {
    return localCocktailRepository.unsetFavorite(cocktail);
  }

  @override
  Future<List<Cocktail>> filterByIngredient(String value, int limit, {int offset = 0}) async {
    var cocktails = await httpCocktailRepository.filterByIngredient(value, limit, offset: offset);
    List<Cocktail> updatedCocktails = [];
    for (var cocktail in cocktails) {
      Cocktail? favoriteCocktail = await localCocktailRepository.getById(cocktail.id);
      if (favoriteCocktail != null) {
        cocktail.favorite = true;
      }
      updatedCocktails.add(cocktail);
    }
    return updatedCocktails;
  }

  @override
  Future<Cocktail?> getById(int id) async {
    var cocktail = await httpCocktailRepository.getById(id);
    if (cocktail == null) {
      return null;
    }
    var favorite = await localCocktailRepository.getById(id);
    if (favorite != null) {
      cocktail.favorite = true;
    }
    return cocktail;
  }
}
