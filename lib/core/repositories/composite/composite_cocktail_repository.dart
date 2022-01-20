import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:collection/collection.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';

class CompositeCocktailRepository implements CocktailRepository {
  final HttpCocktailRepository httpCocktailRepository;
  final LocalCocktailRepository localCocktailRepository;

  CompositeCocktailRepository(
      this.httpCocktailRepository, this.localCocktailRepository);

  @override
  Future<List<Cocktail>> getAll() async {
    var cocktails = await httpCocktailRepository.getAll();
    var favoriteCocktails = await localCocktailRepository.getFavorites();
    cocktails = cocktails.map((c1) {
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.name == c2.name) != null) {
        c1.favorite = true;
      }
      return c1;
    }).toList();
    // localCocktailRepository.save(cocktails);
    return cocktails;
  }

  @override
  Future<List<Cocktail>> getFavorites() {
    return localCocktailRepository.getFavorites();
  }

  @override
  Future<List<Cocktail>> search(String value) async {
    var cocktails = await httpCocktailRepository.search(value);
    var favoriteCocktails = await localCocktailRepository.getFavorites();
    cocktails.map((c1) {
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.name == c2.name) != null) {
        c1.favorite = true;
      }
    });
    // localCocktailRepository.save(cocktails);
    return cocktails;
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
  Future<List<Cocktail>> filterByIngredient(String value) async {
    var cocktails = await httpCocktailRepository.filterByIngredient(value);
    var favoriteCocktails = await localCocktailRepository.getFavorites();
    cocktails.map((c1) {
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.name == c2.name) != null) {
        c1.favorite = true;
      }
    });
    return cocktails;
  }

  @override
  Future<Cocktail?> getByName(String name) async {
    var cocktail = await httpCocktailRepository.getByName(name);
    if (cocktail == null) {
      return null;
    }
    var favorite = await localCocktailRepository.getByName(name);
    if (favorite != null) {
      cocktail.favorite = true;
    }
    return cocktail;
  }
}
