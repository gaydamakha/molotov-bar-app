import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/providers/providers.dart';
import 'package:molotov_bar/view/widgets/cocktails_list_view.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';

class CocktailsSearchPage extends StatefulHookConsumerWidget {
  const CocktailsSearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CocktailsSearchPage> createState() => _CocktailsSearchPageState();
}

class _CocktailsSearchPageState extends ConsumerState<CocktailsSearchPage> {
  static const int defaultIngredientsLimit = 10;

  @override
  Widget build(BuildContext context) {
    ref.watch(cocktailsViewModelProvider);
    final CocktailsViewModel cocktailsViewModel = ref.watch(cocktailsViewModelProvider.notifier);
    final String? selectedIngredient = cocktailsViewModel.ingredient;
    final SearchBar searchBar = SearchBar(
      onSubmitted: (String? value) {
        if (value != null && value.isNotEmpty) {
          cocktailsViewModel.searchCocktails(value);
        } else {
          cocktailsViewModel.resetCocktailsList();
        }
      },
      onSelect: (SelectedListItem? item) {
        if (item != null) {
          cocktailsViewModel.filterByIngredient(item.name);
        } else {
          cocktailsViewModel.resetCocktailsList();
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
            future: ref.read(ingredientRepositoryProvider).getAll(defaultIngredientsLimit, offset: 0),
            builder: (BuildContext context, AsyncSnapshot<List<Ingredient>> snapshot) {
              if (snapshot.hasData) {
                final listOfIngredients = snapshot.data?.map((e) => SelectedListItem(false, e.name)).toList();
                if (selectedIngredient != null) {
                  listOfIngredients?.removeWhere((e) => e.name == selectedIngredient);
                  listOfIngredients?.insert(0, SelectedListItem(true, selectedIngredient));
                }
                searchBar.listOfFilters = listOfIngredients;
                return searchBar;
              }
              return searchBar;
            }),
        const SizedBox(height: 10),
        const Flexible(child: CocktailsListView()),
      ]),
    )));
  }
}
