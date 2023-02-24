import 'package:dio/dio.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/core/models/ingredient_error.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';
import 'package:molotov_bar/core/repositories/ingredient_repository.dart';

class HttpMolotovBarApiIngredientRepository extends BaseHttpRepository
    implements IngredientRepository {
  HttpMolotovBarApiIngredientRepository(Dio dio) : super(dio) {
    dio.options.baseUrl = 'http://localhost/api/v1';
  }

  @override
  Future<List<Ingredient>> getAll(int limit, {int offset = 0, String? keyword}) async {
    var response =
        await get('/ingredients', {'offset': offset, 'limit': limit, 'keyword': keyword});
    if (response.statusCode != 200) {
      throw IngredientError(
          code: 1, message: 'Failed to fetch ingredients (c\'est de la merde)');
    }
    var ingredients = response.data['ingredients'];
    if (ingredients == null) {
      return [];
    }

    return (ingredients as List<dynamic>)
        .map((e) => Ingredient(e.toString()))
        .toList();
  }
}
