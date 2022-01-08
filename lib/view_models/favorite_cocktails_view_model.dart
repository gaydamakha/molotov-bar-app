import 'package:get_it/get_it.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';

class FavoriteCocktailsViewModel extends CocktailsViewModel {
  final CocktailRepository _cocktailRepository =
      GetIt.instance<CocktailRepository>();

  @override
  Map<String, Cocktail> getCocktails() {
    var filtered = Map.of(super.getCocktails())
      ..removeWhere((key, value) => !value.favorite);
    return filtered;
  }

  @override
  initCocktailsList() async {
    setLoading(true);
    var response = await _cocktailRepository.getFavorites();
    try {
      setCocktails(response);
    } on Exception {
      var error = CocktailError(
        code: 111,
        message: 'error',
      );
      setCocktailError(error);
    }
    setLoading(false);
  }
}
