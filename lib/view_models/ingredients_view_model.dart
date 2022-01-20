// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';
// import 'package:molotov_bar/core/models/ingredient.dart';
// import 'package:molotov_bar/core/models/ingredient_error.dart';
// import 'package:molotov_bar/core/repositories/ingredient_repository.dart';
//
// class IngredientsViewModel extends ChangeNotifier {
//   bool _loading = false;
//   late final List<Ingredient> _ingredients;
//   IngredientError? _ingredientError;
//
//   bool get loading => _loading;
//
//   List<Ingredient> get ingredients => _ingredients;
//
//   IngredientError? get ingredientError => _ingredientError;
//
//   final IngredientRepository _ingredientRepository =
//       GetIt.instance<IngredientRepository>();
//
//   IngredientsViewModel() {
//     initIngredientsList();
//   }
//
//   setLoading(bool loading) async {
//     _loading = loading;
//     notifyListeners();
//   }
//
//   initIngredientsList() async {
//     setLoading(true);
//     try {
//       _ingredients = await _ingredientRepository.getAll();
//     } on IngredientError catch (e) {
//       _ingredientError = e;
//     }
//     setLoading(false);
//   }
// }
