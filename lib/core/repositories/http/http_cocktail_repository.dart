import 'dart:convert';

import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository implements CocktailRepository {
  @override
  Future<List<Cocktail>> getAll() async {
    var response = await get('/search.php', {'s': ''});
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = json.decode(response.body)['drinks'];
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
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails (c\'est de la merde)');
    }
    var drinks = json.decode(response.body)['drinks'];
    if (drinks == null) {
      return [];
    }

    return (drinks as List<dynamic>)
        .map((e) => Cocktail.fromCocktailDbJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Cocktail>> getFavorites() {
    throw UnimplementedError();
  }

  @override
  Cocktail setFavorite(Cocktail cocktail) {
    throw UnimplementedError();
  }

  @override
  Cocktail unsetFavorite(Cocktail cocktail) {
    throw UnimplementedError();
  }
}
