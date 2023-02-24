import 'package:molotov_bar/core/models/ingredient.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>> getAll(int limit, {int offset = 0, String? keyword});
}
