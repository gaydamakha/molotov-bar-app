import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository
    implements CocktailRepository {
  @override
  Future<List<Cocktail>> getAll() {
    //TODO call http
    List<Cocktail> cocktails = [Cocktail(), Cocktail()];
    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }
}
