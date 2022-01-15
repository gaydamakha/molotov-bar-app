class CocktailIngredient {
  final String name;
  final String title;
  final String? measurement;
  final double? quantity;

  const CocktailIngredient(this.name, this.title, this.measurement, this.quantity);

  factory CocktailIngredient.fromJson(Map<String, dynamic> json) {
    return CocktailIngredient(json['name'].toString(), json['title'].toString(),
        json['measurement']?.toString(), json['quantity']?.toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'measurement': measurement,
      'quantity': quantity,
    };
  }
}
