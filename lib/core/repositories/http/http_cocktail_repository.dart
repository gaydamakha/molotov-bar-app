import 'package:dio/src/dio.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository implements CocktailRepository {
  HttpCocktailRepository(Dio dio) : super(dio);

  @override
  Future<List<Cocktail>> getAll() async {
    var response = await get('/search.php', {'s': ''});
    if (response.statusCode != 200 && response.statusCode != 304) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = response.data['drinks'];
    if (drinks == null) {
      return [];
    }

    return (drinks as List<dynamic>)
        .map((e) => Cocktail.fromCocktailDbJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Cocktail>> search(String value) async {
    var response = await get('/search.php', {'s': value.trim()});
    if (response.statusCode != 200 && response.statusCode != 304) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = response.data['drinks'];
    if (drinks == null) {
      return [];
    }

    return (drinks as List<dynamic>)
        .map((e) => Cocktail.fromCocktailDbJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Cocktail>> filterByIngredient(String value) async {
    var response = await get('/filter.php', {'i': value.trim()});
    if (response.statusCode != 200 && response.statusCode != 304) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = response.data['drinks'];
    if (drinks == null) {
      return [];
    }

    List<String> cocktailIds =
        (drinks as List<dynamic>).map((e) => e['idDrink'] as String).toList();

    List<Cocktail> cocktails = [];

    for (var id in cocktailIds) {
      var cocktail = await getByName(id);
      if (cocktail != null) {
        cocktails.add(cocktail);
      }
    }
    return cocktails;
  }

  @override
  Future<Cocktail?> getByName(String name) async {
    var response = await get('/lookup.php', {'i': name});
    if (response.statusCode != 200 && response.statusCode != 304) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = response.data['drinks'];
    if (drinks == null) {
      return null;
    }
    return Cocktail.fromCocktailDbJson(drinks[0]);
  }

  @override
  Future<List<Cocktail>> getFavorites() {
    throw UnimplementedError();
  }

  @override
  Future<Cocktail> setFavorite(Cocktail cocktail) async {
    throw UnimplementedError();
  }

  @override
  Future<Cocktail> unsetFavorite(Cocktail cocktail) async {
    throw UnimplementedError();
  }
}
