import 'package:molotov_bar/core/models/ingredient.dart';

class Cocktail {
  final String name;
  final String title;
  final String imageUrl;
  final String description;
  final String recipe;
  final double alcoholDegree;
  final List<Ingredient> ingredients;
  final List<String> categories;
  bool favorite;

  Cocktail(this.name, this.title, this.imageUrl, this.description, this.recipe,
      this.alcoholDegree, this.ingredients, this.categories, this.favorite);

  factory Cocktail.fromJson(Map<String, dynamic> json,
      {bool favorite = false}) {
    var ingredientsJson = json['ingredients'] as List;
    List<Ingredient> ingredients =
        ingredientsJson.map((json) => Ingredient.fromJson(json)).toList();

    var categoriesJson = json['categories'] as List;
    List<String> categories =
        categoriesJson.map((json) => json['title'] as String).toList();

    return Cocktail(
        json['name'].toString(),
        json['title'].toString(),
        json['imageUrl'].toString(),
        json['description'].toString(),
        json['recipe'].toString(),
        json['alcoholDegree'].toDouble(),
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
    };
    return json;
  }
}
