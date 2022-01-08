import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository implements CocktailRepository {
  @override
  Future<List<Cocktail>> getAll() async {
    //TODO call http
    var file = await rootBundle.loadString('assets/samples/margarita.json');
    final jsonResponse = json.decode(file);

    var file2 = await rootBundle.loadString('assets/samples/old_pal.json');
    final jsonResponse2 = json.decode(file2);

    var file3 = await rootBundle.loadString('assets/samples/golden_dream.json');
    final jsonResponse3 = json.decode(file3);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
      Cocktail.fromJson(jsonResponse2),
      Cocktail.fromJson(jsonResponse3),
    ];

    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }

  @override
  Future<List<Cocktail>> search(String value) async {
    //TODO call http

    var file = await rootBundle.loadString('assets/samples/margarita.json');
    final jsonResponse = json.decode(file);

    var file2 = await rootBundle.loadString('assets/samples/old_pal.json');
    final jsonResponse2 = json.decode(file2);

    var file3 = await rootBundle.loadString('assets/samples/golden_dream.json');
    final jsonResponse3 = json.decode(file3);

    List<Cocktail> cocktails = [
      Cocktail.fromJson(jsonResponse),
      Cocktail.fromJson(jsonResponse2),
      Cocktail.fromJson(jsonResponse3),
    ];

    return Future<List<Cocktail>>(() {
      return cocktails;
    });
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
