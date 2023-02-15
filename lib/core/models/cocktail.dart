import 'package:molotov_bar/core/models/cocktail_ingredient.dart';

class Cocktail {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String recipe;
  final double? alcoholDegree;
  final List<CocktailIngredient> ingredients;
  final String category;
  bool favorite;

  Cocktail(this.id, this.name, this.imageUrl, this.description, this.recipe,
      this.alcoholDegree, this.ingredients, this.category, this.favorite);

  factory Cocktail.fromCocktailDbJson(Map<String, dynamic> json,
      {bool favorite = false}) {
    List<CocktailIngredient> ingredients = json.keys
        .where((key) => key.startsWith('strIngredient'))
        .map((key) {
          if (json[key] == null) {
            return null;
          }
          String index = key[key.length - 1];
          return CocktailIngredient(json[key],
              json['strMeasure' + index]?.toString().trim(), null);
        })
        .whereType<CocktailIngredient>()
        .toList();

    return Cocktail(
        int.parse(json['idDrink']),
        json['strDrink'].toString(),
        json['strDrinkThumb'].toString(),
        '',
        json['strInstructions'].toString(),
        null,
        ingredients,
        json['strCategory'].toString(),
        favorite);
  }

  factory Cocktail.fromJson(Map<String, dynamic> json,
      {bool favorite = false}) {
    var ingredientsJson = json['ingredients'] as List;
    List<CocktailIngredient> ingredients = ingredientsJson
        .map((json) => CocktailIngredient.fromJson(json))
        .toList();

    return Cocktail(
      json['id'],
      json['name'].toString(),
      json['image_url'].toString(),
      json['description'].toString(),
      json['recipe'].toString(),
      json['alcohol_degree'],
      ingredients,
      json['category'].toString(),
      favorite,
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
      'recipe': recipe,
      'alcohol_degree': alcoholDegree,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'category': category,
      'favorite': favorite,
    };
    return json;
  }
}
