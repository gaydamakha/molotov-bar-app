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
  @override
  Widget build(BuildContext context) {
    ref.watch(cocktailsViewModelProvider);
    final CocktailsViewModel cocktailsViewModel =
        ref.watch(cocktailsViewModelProvider.notifier);
    final AsyncValue<List<Ingredient>> ingredients =
        ref.watch(ingredientsProvider);
    final CocktailError? error = cocktailsViewModel.getError();
    final bool isLoading = cocktailsViewModel.isLoading();
    final List<Cocktail> cocktails = cocktailsViewModel.getCocktails();
    final String? selectedIngredient = cocktailsViewModel.ingredient;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Column(children: <Widget>[
        SearchBar(
          onSubmitted: (String? value) {
            if (value != null && value.isNotEmpty) {
              ref
                  .read(cocktailsViewModelProvider.notifier)
                  .searchCocktails(value);
              ref.read(cocktailsViewModelProvider.notifier).ingredient = null;
            } else {
              ref.read(cocktailsViewModelProvider.notifier).initCocktailsList();
            }
          },
          listOfFilters: ingredients.when(
              data: (ingredientsList) {
                final list = ingredientsList
                    .map((e) => SelectedListItem(false, e.title))
                    .toList();
                if (selectedIngredient != null) {
                  list.removeWhere((e) => e.name == selectedIngredient);
                  list.insert(0, SelectedListItem(true, selectedIngredient));
                }
                return list;
              },
              error: (err, stack) => [],
              loading: () => []),
          onSelect: (SelectedListItem? item) {
            ref.read(cocktailsViewModelProvider.notifier).ingredient =
                item?.name;
            if (item != null) {
              ref
                  .read(cocktailsViewModelProvider.notifier)
                  .filterByIngredient(item.name);
            } else {
              ref.read(cocktailsViewModelProvider.notifier).initCocktailsList();
            }
          },
        ),
        const SizedBox(height: 10),
        error != null
            ? Expanded(child: Center(child: Text(error.message)))
            : const SizedBox(),
        isLoading
            ? const Expanded(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : Flexible(child: CocktailsList(cocktailsList: cocktails)),
      ]),
    )));
  }
}
