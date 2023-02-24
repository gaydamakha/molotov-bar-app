import 'package:dio/dio.dart';

abstract class BaseHttpRepository {
  final Dio dio;

  BaseHttpRepository(this.dio) {
    dio.options.baseUrl = 'http://localhost/api/v1';
  }

  Future<Response<dynamic>> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    return dio.get(path, queryParameters: queryParameters);
  }
}
