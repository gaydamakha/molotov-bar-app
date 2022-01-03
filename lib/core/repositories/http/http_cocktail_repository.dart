import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/base_http_repository.dart';

class HttpCocktailRepository extends BaseHttpRepository implements CocktailRepository {
  @override
  Future<List<Cocktail>> getAll() {
    //TODO call http
    List<Cocktail> cocktails = [
      const Cocktail(1, "Punch à la mirabelle", "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"),
      const Cocktail(2, "Old Fashioned", "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg"),
      const Cocktail(4, "Old Fashioned", "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg"),
      const Cocktail(3, "Punch à la mirabelle", "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"),
      const Cocktail(5, "Punch à la mirabelle", "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"),
      const Cocktail(6, "Old Fashioned", "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg"),
      const Cocktail(4, "Old Fashioned", "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg"),
      const Cocktail(3, "Punch à la mirabelle", "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg"),
    ];
    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }

  @override
  Future<List<Cocktail>> search(String value) {
    //TODO call http
    List<Cocktail> cocktails = [
      const Cocktail(7, "Golden dream", "https://www.thecocktaildb.com/images/media/drink/qrot6j1504369425.jpg"),
      const Cocktail(8, "Old Pal", "https://www.thecocktaildb.com/images/media/drink/x03td31521761009.jpg"),
    ];
    return Future<List<Cocktail>>(() {
      return cocktails;
    });
  }
}
