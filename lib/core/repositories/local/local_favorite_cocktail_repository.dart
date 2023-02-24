import 'dart:convert';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/base_local_repository.dart';

class LocalCocktailRepository extends BaseLocalRepository implements CocktailRepository {
  final String table = 'favorite_cocktails';

  @override
  Future<List<Cocktail>> getFavorites(int limit, {int offset = 0}) async {
    var conn = await connection;
    var result = await conn.query(table, columns: ['cocktail'], limit: limit, offset: offset);
    return List.generate(result.length, (i) {
      return _fromDatabase(result[i]);
    });
  }

  Cocktail _fromDatabase(Map<String, Object?> result) {
    var cocktail = Cocktail.fromJson(jsonDecode(result['cocktail'] as String));
    cocktail.favorite = true;
    return cocktail;
  }

  @override
  Future<Cocktail> setFavorite(Cocktail cocktail) async {
    cocktail.favorite = true;
    var conn = await connection;
    conn.insert(table, <String, Object?>{
      'id': cocktail.id,
      'cocktail': jsonEncode(cocktail.toJson()),
    });
    return cocktail;
  }

  @override
  Future<Cocktail> unsetFavorite(Cocktail cocktail) async {
    cocktail.favorite = false;
    var conn = await connection;
    conn.delete(table, where: 'id = ?', whereArgs: [cocktail.id]);
    return cocktail;
  }

  @override
  Future<Cocktail?> getById(int id) async {
    var conn = await connection;
    var result = await conn.query(table, columns: ['cocktail'], where: 'id = ?', whereArgs: [id]);
    return result.isEmpty ? null : _fromDatabase(result[0]);
  }

  @override
  Future<List<Cocktail>> search(String value, int limit, {int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Cocktail>> getAll(int limit, {int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Cocktail>> filterByIngredient(String value, int limit, {int offset = 0}) {
    throw UnimplementedError();
  }
}
