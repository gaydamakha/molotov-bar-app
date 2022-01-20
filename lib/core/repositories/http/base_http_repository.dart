import 'package:dio/dio.dart';

abstract class BaseHttpRepository {
  final Uri baseUri = Uri.parse('https://www.thecocktaildb.com/api/json/v1/1');
  final Dio dio;

  BaseHttpRepository(this.dio);

  Future<Response<dynamic>> get(
      String uri, Map<String, dynamic>? queryParameters) async {
    return dio.get(baseUri.replace(pathSegments: [baseUri.path, uri], queryParameters: queryParameters).toString());
  }
}
