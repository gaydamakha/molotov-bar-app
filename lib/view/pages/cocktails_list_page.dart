import 'package:flutter/material.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/view/widgets/cocktail_tile.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

class CocktailsListPage extends StatefulWidget {
  const CocktailsListPage({Key? key}) : super(key: key);

  @override
  State<CocktailsListPage> createState() => _CocktailsListPageState();
}

class _CocktailsListPageState extends State<CocktailsListPage> {
  @override
  Widget build(BuildContext context) {
    CocktailsViewModel cocktailsViewModel = context.watch<CocktailsViewModel>();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SearchBar(onSubmitted: (value) {
            if (value.isNotEmpty) {
              cocktailsViewModel.searchCocktails(value);
            }
          }),
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_ui(cocktailsViewModel)],
        )),
      ],
    )));
  }

  Widget _ui(CocktailsViewModel cocktailsViewModel) {
    if (cocktailsViewModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (cocktailsViewModel.cocktailError != null) {
      return Text(cocktailsViewModel.cocktailError!.message);
    }
    // return
    return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              Cocktail cocktail = cocktailsViewModel.cocktailsList[index];
              return CocktailTile(
                name: cocktail.title,
                imageUrl: cocktail.imageUrl,
                onTileTap: () => context.router.push(CocktailDetailRoute(drinkId: cocktail.id)),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cocktailsViewModel.cocktailsList.length));
  }
}
