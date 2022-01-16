import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/providers/providers.dart';

class FavoritesListPage extends ConsumerStatefulWidget {
  const FavoritesListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends ConsumerState<FavoritesListPage> {
  @override
  Widget build(BuildContext context) {
    final CocktailsViewModel cocktailsViewModel =
        ref.watch<CocktailsViewModel>(cocktailsViewModelProvider.notifier);
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
        Flexible(child: _ui(cocktailsViewModel)),
      ]),
    )));
  }

  Widget _ui(CocktailsViewModel cocktailsViewModel) {
    return CocktailsList(cocktailsList: cocktailsViewModel.getFavorites());
  }
}
