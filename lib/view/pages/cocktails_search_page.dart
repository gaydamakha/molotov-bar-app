import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/providers/providers.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';

class CocktailsSearchPage extends StatefulHookConsumerWidget {
  const CocktailsSearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CocktailsSearchPage> createState() =>
      _CocktailsSearchPageState();
}

class _CocktailsSearchPageState extends ConsumerState<CocktailsSearchPage> {
  static const int defaultIngredientsLimit = 10;

  @override
  Widget build(BuildContext context) {
    ref.watch(cocktailsViewModelProvider);
    final CocktailsViewModel cocktailsViewModel =
    ref.watch(cocktailsViewModelProvider.notifier);
    final CocktailError? error = cocktailsViewModel.getError();
    final bool isLoading = cocktailsViewModel.isLoading();
    final List<Cocktail> cocktails = cocktailsViewModel.getCocktails();
    final String? selectedIngredient = cocktailsViewModel.ingredient;
    final SearchBar searchBar = SearchBar(
      onSubmitted: (String? value) {
        if (value != null && value.isNotEmpty) {
          ref
              .read(cocktailsViewModelProvider.notifier)
              .searchCocktails(value);
          ref
              .read(cocktailsViewModelProvider.notifier)
              .ingredient = null;
        } else {
          ref.read(cocktailsViewModelProvider.notifier)
              .initCocktailsList();
        }
      },
      onSelect: (SelectedListItem? item) {
        ref
            .read(cocktailsViewModelProvider.notifier)
            .ingredient =
            item?.name;
        if (item != null) {
          ref
              .read(cocktailsViewModelProvider.notifier)
              .filterByIngredient(item.name);
        } else {
          ref.read(cocktailsViewModelProvider.notifier)
              .initCocktailsList();
        }
      },
    );
    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
              ),
              child: Column(children: <Widget>[
                FutureBuilder<List<Ingredient>>(
                    future: ref.read(ingredientRepositoryProvider).getAll(
                        defaultIngredientsLimit),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Ingredient>> snapshot) {
                      if (snapshot.hasData) {
                        final listOfFilters = snapshot.data
                            ?.map((e) => SelectedListItem(false, e.name))
                            .toList();
                        if (selectedIngredient != null) {
                          listOfFilters?.removeWhere((e) =>
                          e.name == selectedIngredient);
                          listOfFilters?.insert(
                              0, SelectedListItem(
                              true, selectedIngredient));
                        }
                        searchBar.listOfFilters = listOfFilters;
                        return searchBar;
                      }
                      return searchBar;
                    }),
                const SizedBox(height: 10),
                error != null
                    ? Expanded(child: Center(child: Text(error.message)))
                    : const SizedBox(),
                isLoading
                    ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                    : cocktails.isNotEmpty
                    ? Flexible(child: CocktailsList(cocktailsList: cocktails))
                    : Expanded(
                  child: Center(
                    child: Text(
                      'Ops... nothing found!',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6,
                    ),
                  ),
                ),
              ]),
            )));
  }
}
