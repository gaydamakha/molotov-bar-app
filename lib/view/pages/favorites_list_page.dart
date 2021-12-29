import 'package:flutter/material.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/view/widgets/cocktail_tile.dart';
import 'package:auto_route/auto_route.dart';

class FavoritesListPage extends StatelessWidget {
  const FavoritesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CocktailTile(name: "Punch à la mirabelle",
          imageUrl: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
          onTileTap: () => context.router.push(CocktailDetailRoute(drinkId: 1)),
        ),
      ),
    );
  }
}
