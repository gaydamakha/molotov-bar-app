class CocktailIngredient {
  final String name;
  final String? measurement;
  final double? quantity;

  const CocktailIngredient(this.name, this.measurement, this.quantity);

  factory CocktailIngredient.fromJson(Map<String, dynamic> json) {
    return CocktailIngredient(json['name'].toString(),
        json['measurement']?.toString(), json['quantity']?.toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'measurement': measurement,
      'quantity': quantity,
    };
  }
}
