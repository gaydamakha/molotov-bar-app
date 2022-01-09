import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/theme/app_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/view_models/favorite_cocktails_view_model.dart';
import 'package:provider/provider.dart';

class CocktailDetailPage extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailPage({
    Key? key,
    required this.cocktail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CocktailsViewModel cocktailsViewModel = context.watch<CocktailsViewModel>();
    FavoriteCocktailsViewModel favoriteCocktailsViewModel = context.read<FavoriteCocktailsViewModel>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.6),
              onPressed: () {
                context.router.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
            FloatingActionButton(
              backgroundColor:
                  Theme.of(context).backgroundColor.withOpacity(0.6),
              onPressed: () {
                if (cocktail.favorite) {
                  cocktailsViewModel.unsetCocktailFavorite(cocktail);
                } else {
                  cocktailsViewModel.setCocktailFavorite(cocktail);
                }
                favoriteCocktailsViewModel.refresh();
              },
              child: Icon(
                cocktail.favorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(144.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          cocktail.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppIcons.drop, height: 20),
                        title: Text(
                          cocktail.alcoholDegree.toString() + " %",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        minLeadingWidth: 0,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(AppIcons.list, height: 20),
                        title: Text(
                          cocktail.categories[0],
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        minLeadingWidth: 0,
                      ),
                    ])),
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    cocktail.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.7),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 24,
              right: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Text("Ingredients",
                      style: Theme.of(context).textTheme.headline4),
                  ListBody(
                    children: cocktail.ingredients.map((ingredient) {
                      return ListTile(
                        visualDensity: const VisualDensity(
                            horizontal: -4.0, vertical: -4.0),
                        title: Text([
                          ingredient.title,
                          ingredient.quantity?.toString(),
                          ingredient.measurement
                        ].where((e) => e != null).join(" ")),
                      );
                    }).toList(),
                  ),
                  Text("Recipe", style: Theme.of(context).textTheme.headline4),
                  ListTile(
                    title: Text(cocktail.recipe,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.2,
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
