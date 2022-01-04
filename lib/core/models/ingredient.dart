class Ingredient{
  final String name;
  final String title;
  final String measurement;
  final double? quantity;

  const Ingredient(this.name,this.title,this.measurement,this.quantity);

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(json['name'].toString(), json['title'].toString(), json['measurement'].toString(), json['quantity'] == null ? null : json['quantity'] as double);
  }
}
