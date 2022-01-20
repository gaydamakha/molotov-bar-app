import 'package:molotov_bar/core/models/cocktail_ingredient.dart';

class Cocktail {
  final String name;
  final String title;
  final String imageUrl;
  final String description;
  final String recipe;
  final double? alcoholDegree;
  final List<CocktailIngredient> ingredients;
  final List<String> categories;
  bool favorite;

  Cocktail(this.name, this.title, this.imageUrl, this.description, this.recipe,
      this.alcoholDegree, this.ingredients, this.categories, this.favorite);

  factory Cocktail.fromCocktailDbJson(Map<String, dynamic> json,
      {bool favorite = false}) {
    List<CocktailIngredient> ingredients = json.keys
        .where((key) => key.startsWith('strIngredient'))
        .map((key) {
          if (json[key] == null) {
            return null;
          }
          String index = key[key.length - 1];
          return CocktailIngredient('', json[key],
              json['strMeasure' + index]?.toString().trim(), null);
        })
        .whereType<CocktailIngredient>()
        .toList();

    List<String> categories = [json['strCategory'].toString()];

    return Cocktail(
        json['idDrink'].toString(),
        json['strDrink'].toString(),
        json['strDrinkThumb'].toString(),
        '',
        json['strInstructions'].toString(),
        null,
        ingredients,
        categories,
        favorite);
  }

  factory Cocktail.fromJson(Map<String, dynamic> json,
      {bool favorite = false}) {
    var ingredientsJson = json['ingredients'] as List;
    List<CocktailIngredient> ingredients = ingredientsJson
        .map((json) => CocktailIngredient.fromJson(json))
        .toList();

    var categoriesJson = json['categories'] as List;
    List<String> categories =
        categoriesJson.map((json) => json['title'] as String).toList();

    return Cocktail(
        json['name'].toString(),
        json['title'].toString(),
        json['imageUrl'].toString(),
        json['description'].toString(),
        json['recipe'].toString(),
        json['alcoholDegree']?.toDouble(),
        ingredients,
        categories,
        favorite);
  }

  Map<String, dynamic> toJson() {
    var json = {
      'name': name,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'recipe': recipe,
      'alcoholDegree': alcoholDegree,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => {'title': e}).toList(),
      'favorite': favorite,
    };
    return json;
  }
}
