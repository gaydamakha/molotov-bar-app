import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  @override
  Widget build(BuildContext context) {
    ref.watch(cocktailsViewModelProvider);
    final CocktailsViewModel cocktailsViewModel = ref.watch(cocktailsViewModelProvider.notifier);
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
        searchBar,
        const SizedBox(height: 10),
        const Flexible(child: CocktailsListView()),
      ]),
    )));
  }
}
