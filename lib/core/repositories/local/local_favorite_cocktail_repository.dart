import 'dart:convert';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/base_local_repository.dart';

class LocalCocktailRepository extends BaseLocalRepository
    implements CocktailRepository {
  final String table = 'favorite_cocktails';

  @override
  Future<List<Cocktail>> getFavorites() async {
    var conn = await connection;
    var result = await conn.query(table, columns: ['cocktail']);
    return List.generate(result.length,
            (i) {
          return _fromDatabase(result[i]);
        });
  }

  Cocktail _fromDatabase(Map<String, Object?> result) {
    var cocktail = Cocktail.fromJson(jsonDecode(result['cocktail'] as String));
    cocktail.favorite = true;
    return cocktail;
  }

  void save(List<Cocktail> cocktails) {
    // TODO: implement setFavorite
  }

  @override
  Future<Cocktail> setFavorite(Cocktail cocktail) async {
    cocktail.favorite = true;
    var conn = await connection;
    conn.insert(table, <String, Object?>{
      'name': cocktail.name,
      'cocktail': jsonEncode(cocktail.toJson()),
    });
    return cocktail;
  }

  @override
  Future<Cocktail> unsetFavorite(Cocktail cocktail) async {
    cocktail.favorite = false;
    var conn = await connection;
    conn.delete(table, where: 'name = ?', whereArgs: [cocktail.name]);
    return cocktail;
  }

  @override
  Future<Cocktail?> getByName(String name) async {
    var conn = await connection;
    var result = await conn.query(table, columns: ['cocktail'], where: 'name = ?' ,whereArgs: [name]);
    return result.isEmpty ? null : _fromDatabase(result[0]);
  }

  @override
  Future<List<Cocktail>> search(String value) {
    throw UnimplementedError();
  }

  @override
  Future<List<Cocktail>> getAll() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Cocktail>> filterByIngredient(String value) {
    throw UnimplementedError();
  }
}
