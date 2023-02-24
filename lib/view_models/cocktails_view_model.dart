import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';

class CocktailsViewModel extends StateNotifier<PagingController<int, Cocktail>> {
  final CocktailRepository _cocktailRepository;
  final int cocktailsPerPage;

  CocktailsViewModel(this._cocktailRepository, this.cocktailsPerPage) : super(PagingController(firstPageKey: 0)) {
    initCocktailsList();
  }

  PagingController<int, Cocktail> getPagingController() => state;

  String? _ingredient;

  String? get ingredient => _ingredient;
  String? _search;

  _appendCocktails(List<Cocktail> cocktailsList, int pageKey) {
    final isLastPage = cocktailsList.length < cocktailsPerPage;
    if (isLastPage) {
      state.appendLastPage(cocktailsList);
    } else {
      final nextPageKey = pageKey + cocktailsList.length;
      state.appendPage(cocktailsList, nextPageKey);
    }
  }

  _setError(CocktailError cocktailError) {
    state.error = cocktailError;
  }

  void initCocktailsList() {
    state.addPageRequestListener((pageKey) {
      _fetchMoreCocktails(pageKey);
    });
  }

  Future<void> searchCocktails(String value) async {
    _ingredient = null;
    _search = value;
    try {
      final cocktails = await _cocktailRepository.search(value, cocktailsPerPage);
      state.itemList = cocktails;
    } on CocktailError catch (e) {
      _setError(e);
    }
  }

  Future<void> filterByIngredient(String value) async {
    _ingredient = value;
    _search = null;
    try {
      final cocktails = await _cocktailRepository.filterByIngredient(value, cocktailsPerPage);
      state.itemList = cocktails;
    } on CocktailError catch (e) {
      _setError(e);
    }
  }

  Future<void> resetCocktailsList() async {
    state.nextPageKey = 0;
    _search = null;
    _ingredient = null;
    state.refresh();
  }

  Future<void> _fetchMoreCocktails(int pageKey) async {
    if (_search != null || _ingredient != null) {
      state.appendLastPage([]);
      return;
    }
    try {
      final newCocktails = await _cocktailRepository.getAll(cocktailsPerPage, offset: pageKey);
      _appendCocktails(newCocktails, pageKey);
    } on CocktailError catch (e) {
      _setError(e);
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
