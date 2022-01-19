import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/providers/providers.dart';

class FavoritesListPage extends StatefulHookConsumerWidget {
  const FavoritesListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends ConsumerState<FavoritesListPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(cocktailsViewModelProvider);
    ref.watch(favoriteCocktailsViewModelProvider);
    final cocktails = ref.watch(favoriteCocktailsViewModelProvider.notifier).getCocktails();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Column(children: <Widget>[
        const SizedBox(height: 10),
        Flexible(child: CocktailsList(cocktailsList: cocktails)),
      ]),
    )));
  }
}
