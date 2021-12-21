import 'package:http/http.dart' as http;

class Api {
  static const endpoint = '';

  final client = http.Client();

  Future<List<Cocktail>> getCocktails() async {
    
  }
}