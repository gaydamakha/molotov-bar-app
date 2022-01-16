import 'package:molotov_bar/core/models/ingredient.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>> getAll();
}
