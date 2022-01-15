import 'package:http/http.dart' as http;

abstract class BaseHttpRepository {
  final Uri baseUri = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1');

  final client = http.Client();

  Future<http.Response> get(
      String uri, Map<String, dynamic>? queryParameters) async {
    return client.get(baseUri.replace(
        pathSegments: [baseUri.path, uri], queryParameters: queryParameters));
  }
}
