import 'package:flutter/material.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/view_models/favorite_cocktails_view_model.dart';
import 'package:provider/provider.dart';

class FavoritesListPage extends StatefulWidget {
  const FavoritesListPage({Key? key}) : super(key: key);

  @override
  State<FavoritesListPage> createState() => _FavoritesListPageState();
}

class _FavoritesListPageState extends State<FavoritesListPage> {
  @override
  Widget build(BuildContext context) {
    context.watch<CocktailsViewModel>();
    FavoriteCocktailsViewModel favoriteCocktailsViewModel = context.watch<FavoriteCocktailsViewModel>();
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
                Flexible(child: _ui(favoriteCocktailsViewModel)),
              ]),
            )));
  }

  Widget _ui(FavoriteCocktailsViewModel favoriteCocktailsViewModel) {
    if (favoriteCocktailsViewModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (favoriteCocktailsViewModel.cocktailError != null) {
      return Text(favoriteCocktailsViewModel.cocktailError!.message);
    }
    return CocktailsList(cocktailsList: favoriteCocktailsViewModel.getCocktails().values.toList());
  }
}
