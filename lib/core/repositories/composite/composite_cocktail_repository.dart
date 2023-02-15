import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:collection/collection.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';

class CompositeCocktailRepository implements CocktailRepository {
  final CocktailRepository httpCocktailRepository;
  final LocalCocktailRepository localCocktailRepository;

  CompositeCocktailRepository(
      this.httpCocktailRepository, this.localCocktailRepository);

  @override
  Future<List<Cocktail>> getAll() async {
    var cocktails = await httpCocktailRepository.getAll();
    var favoriteCocktails = await localCocktailRepository.getFavorites();
    cocktails = cocktails.map((c1) {
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.id == c2.id) != null) {
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
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.id == c2.id) != null) {
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
      if (favoriteCocktails.firstWhereOrNull((c2) => c1.id == c2.id) != null) {
        c1.favorite = true;
      }
    });
    return cocktails;
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
