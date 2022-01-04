import 'package:molotov_bar/core/models/ingredient.dart';

class Cocktail {
  final String name;
  final String title;
  final String imageUrl;
  final String description;
  final String recipe;
  final double alcoholDegree;
  final List<Ingredient> ingredients;

  const Cocktail(this.name, this.title, this.imageUrl, this.description, this.recipe, this.alcoholDegree, this.ingredients);

  factory Cocktail.fromJson(Map<String, dynamic> json) {

   var ingredientsJson = json['ingredients'] as List;
   List<Ingredient> ingredients = ingredientsJson.map((json) => Ingredient.fromJson(json)).toList();

   return Cocktail(
     json['name'].toString(),
     json['title'].toString(),
     json['imageUrl'].toString(),
     json['description'].toString(),
     json['recipe'].toString(),
     json['alcoholDegree'].toDouble(),
     ingredients
   );
  }
}
