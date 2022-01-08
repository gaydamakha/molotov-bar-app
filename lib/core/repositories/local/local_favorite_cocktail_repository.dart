import 'dart:convert';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalCocktailRepository implements CocktailRepository
{
  @override
  Future<List<Cocktail>> getFavorites() async{
    var file = await rootBundle.loadString('assets/samples/margarita.json');
    final jsonResponse = json.decode(file);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
    ];

    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }

  @override
  Future<List<Cocktail>> getAll() async {
    var file = await rootBundle.loadString('assets/samples/margarita.json');
    final jsonResponse = json.decode(file);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
    ];

    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }

  void save(List<Cocktail> cocktails) {
    // TODO: implement setFavorite
  }

  @override
  Cocktail setFavorite(Cocktail cocktail) {
    // TODO: implement setFavorite
    throw UnimplementedError();
  }

  @override
  Cocktail unsetFavorite(Cocktail cocktail) {
    // TODO: implement unsetFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Cocktail>> search(String value) {
    throw UnimplementedError();
  }
}
