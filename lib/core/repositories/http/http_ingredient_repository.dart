import 'package:dio/src/dio.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/core/models/ingredient_error.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';
import 'package:molotov_bar/core/repositories/ingredient_repository.dart';

class HttpIngredientRepository extends BaseHttpRepository implements IngredientRepository {
  HttpIngredientRepository(Dio dio) : super(dio);

  @override
  Future<List<Ingredient>> getAll() async {
    var response = await get('/list.php', {'i': 'list'});
    if (response.statusCode != 200) {
      throw IngredientError(
          code: 1, message: 'Failed to fetch ingredients (c\'est de la merde)');
    }
    var ingredients = response.data['drinks'];
    if (ingredients == null) {
      return [];
    }

    return (ingredients as List<dynamic>)
        .map((e) => Ingredient.fromCocktailDbJson(e as Map<String, dynamic>))
        .toList();
  }
}
