import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/providers/providers.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';

class CocktailsSearchPage extends StatefulHookConsumerWidget {
  const CocktailsSearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CocktailsSearchPage> createState() => _CocktailsSearchPageState();
}

class _CocktailsSearchPageState extends ConsumerState<CocktailsSearchPage> {
  @override
  Widget build(BuildContext context) {
    final CocktailsViewModel cocktailsViewModel =
        ref.watch(cocktailsViewModelProvider.notifier);
    final AsyncValue<List<Ingredient>> ingredients =
        ref.watch(ingredientsProvider);
    final error = ref.watch(cocktailsViewModelProvider.notifier).getError();
    final isLoading = ref.watch(cocktailsViewModelProvider.notifier).isLoading();
    final cocktails = ref.watch(cocktailsViewModelProvider.notifier).getCocktails();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Column(children: <Widget>[
        ingredients.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (ingredientsList) {
            return SearchBar(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  cocktailsViewModel.searchCocktails(value);
                }
              },
              listOfFilters: ingredientsList.map((e) => e.title).toList(),
            );
          },
        ),
        const SizedBox(height: 10),
        error != null ? Text(error.message) : const SizedBox(),
        isLoading
            ? const CircularProgressIndicator()
            : Flexible(child: CocktailsList(cocktailsList: cocktails)),
      ]),
    )));
  }
}
