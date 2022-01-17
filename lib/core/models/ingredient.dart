class Ingredient {
  final String title;

  const Ingredient(this.title);

  factory Ingredient.fromCocktailDbJson(Map<String, dynamic> json) {
    return Ingredient(json['strIngredient1'].toString());
  }
}
