import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'cocktail_tile.dart';

class CocktailsList extends StatelessWidget {
  final List<Cocktail> cocktailsList;

  const CocktailsList({Key? key, required this.cocktailsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: cocktailsList
            .map((cocktail) => CocktailTile(
                  name: cocktail.name,
                  imageUrl: cocktail.imageUrl,
                  onTileTap: () => context.router
                      .push(CocktailDetailRoute(cocktailId: cocktail.id)),
                ))
            .toList());
  }
}
