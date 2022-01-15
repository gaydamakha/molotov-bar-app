class Ingredient {
  final String title;

  Ingredient(this.title);

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(json['strIngredient1'].toString());
  }
}
