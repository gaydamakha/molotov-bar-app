import 'package:http/http.dart' as http;

abstract class BaseHttpRepository {
  final String baseUrl = "";

  final client = http.Client();
}
