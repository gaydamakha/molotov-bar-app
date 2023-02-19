import 'package:dio/dio.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpMolotovBarApiCocktailRepository extends BaseHttpRepository
    implements CocktailRepository {
  HttpMolotovBarApiCocktailRepository(Dio dio) : super(dio) {
    dio.options.baseUrl = 'http://localhost/api/v1';
  }

  //TODO: add offset and limit
  @override
  Future<List<Cocktail>> getAll() async {
    var response = await get('/cocktails');
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails');
    }
    var cocktails = response.data['cocktails'];
    if (cocktails == null) {
      return [];
    }

    return (cocktails as List<dynamic>)
        .map((e) => Cocktail.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Cocktail>> search(String value) async {
    var response = await get('/cocktails', {'keyword': value});
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails');
    }
    var cocktails = response.data['cocktails'];
    if (cocktails == null) {
      return [];
    }

    return (cocktails as List<dynamic>)
        .map((e) => Cocktail.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Cocktail>> filterByIngredient(String ingredient) async {
    var response = await get('/cocktails', {'ing': ingredient});
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails');
    }
    var cocktails = response.data['cocktails'];
    if (cocktails == null) {
      return [];
    }

    return (cocktails as List<dynamic>)
        .map((e) => Cocktail.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Cocktail?> getById(int id) async {
    var response = await get('/cocktails/$id');
    if (response.statusCode != 200) {
      throw CocktailError(
          code: 1, message: 'Failed to fetch cocktails');
    }

    return Cocktail.fromJson(response.data);
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
