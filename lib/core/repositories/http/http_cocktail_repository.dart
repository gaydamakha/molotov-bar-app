import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository implements CocktailRepository {
  @override
  Future<List<Cocktail>> getAll() async {
    //TODO call http
    var file = await rootBundle.loadString('samples/margarita.json');
    final jsonResponse = json.decode(file);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
    ];

    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }

  @override
  Future<List<Cocktail>> search(String value) async {
    //TODO call http

    var file = await rootBundle.loadString('samples/margarita.json');
    final jsonResponse = json.decode(file);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
    ];
    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }
}
