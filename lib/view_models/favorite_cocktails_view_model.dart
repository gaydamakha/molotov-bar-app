import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/states/cocktails_list_state.dart';

class FavoriteCocktailsViewModel extends StateNotifier<CocktailsListState> {
  final CocktailRepository _cocktailRepository;
  final int cocktailsPerPage;

  FavoriteCocktailsViewModel(this._cocktailRepository, this.cocktailsPerPage) : super(const CocktailsListState()) {
    initCocktailsList();
  }

  final PagingController<int, Cocktail> _pagingController = PagingController(firstPageKey: 0);

  PagingController<int, Cocktail> getPagingController() => _pagingController;

  _appendCocktails(List<Cocktail> cocktailsList, int pageKey) {
    final isLastPage = cocktailsList.length < cocktailsPerPage;
    if (isLastPage) {
      _pagingController.appendLastPage(cocktailsList);
    } else {
      final nextPageKey = pageKey + cocktailsList.length;
      _pagingController.appendPage(cocktailsList, nextPageKey);
    }
    state = state.copyWith(cocktails: {for (var c in cocktailsList) c.id: c});
  }

  Future<Cocktail> setCocktailFavorite(Cocktail cocktail) async {
    final ctl = await _cocktailRepository.setFavorite(cocktail);
    _pagingController.value = PagingState<int, Cocktail>(
      itemList: (_pagingController.itemList ?? []) + [cocktail],
      error: null,
      nextPageKey: _pagingController.nextPageKey,
    );
    final cocktails = state.cocktails;
    cocktails[ctl.id] = ctl;
    state = state.copyWith(cocktails: cocktails);
    return ctl;
  }

  Future<void> unsetCocktailFavorite(Cocktail cocktail) async {
    await _cocktailRepository.unsetFavorite(cocktail);
    var newList = List<Cocktail>.from(_pagingController.itemList ?? [])
      ..removeWhere((element) => cocktail.id == element.id);

    _pagingController.value = PagingState<int, Cocktail>(
      itemList: newList,
      error: null,
      nextPageKey: _pagingController.nextPageKey,
    );
    final cocktails = state.cocktails;
    cocktails.remove(cocktail.id);
    state = state.copyWith(cocktails: cocktails);
    return;
  }

  Future<void> initCocktailsList() async {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMoreCocktails(pageKey);
    });
  }

  Future<void> _fetchMoreCocktails(int pageKey) async {
    try {
      final newCocktails = await _cocktailRepository.getFavorites(cocktailsPerPage, offset: pageKey);
      _appendCocktails(newCocktails, pageKey);
    } on CocktailError catch (e) {
      _setError(e);
    }
  }

  _setError(CocktailError cocktailError) {
    _pagingController.error = cocktailError;
  }
}
