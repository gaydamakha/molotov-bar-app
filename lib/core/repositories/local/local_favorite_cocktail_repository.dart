import 'dart:convert';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/favorite_cocktail_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalFavoriteCocktailRepository implements FavoriteCocktailRepository
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
}