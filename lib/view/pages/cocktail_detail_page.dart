import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/theme/app_colors.dart';
import 'package:molotov_bar/theme/app_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:molotov_bar/providers/providers.dart';

final detailCocktailProvider = FutureProvider.autoDispose.family<Cocktail?, int>((ref, id) async {
  final repository = ref.watch(cocktailRepositoryProvider);
  return await repository.getById(id);
});

final isCocktailFavoriteProvider = StateProvider.autoDispose.family<bool, int>((ref, id) {
  ref.watch(cocktailsViewModelProvider);
  return ref.watch(favoriteCocktailsViewModelProvider.select((state) => state.cocktails.containsKey(id)));
});

class CocktailDetailPage extends ConsumerWidget {
  final int cocktailId;

  const CocktailDetailPage({
    Key? key,
    required this.cocktailId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cocktail = ref.watch(detailCocktailProvider(cocktailId));
    var isFavorite = ref.watch(isCocktailFavoriteProvider(cocktailId));
    return cocktail.when(data: (cocktail) {
      if (cocktail == null) {
        return const Scaffold(
          body: Center(child: Text('Internal error occurred')),
        );
      } else {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.6),
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
                  backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.6),
                  onPressed: () {
                    if (isFavorite) {
                      ref.read(favoriteCocktailsViewModelProvider.notifier).unsetCocktailFavorite(cocktail);
                    } else {
                      ref.read(favoriteCocktailsViewModelProvider.notifier).setCocktailFavorite(cocktail);
                    }
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(144.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ListTile(
                        title: Text(
                          cocktail.name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      cocktail.alcoholDegree == null
                          ? const SizedBox()
                          : ListTile(
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
                          cocktail.category,
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
                        errorBuilder: (ctx, obj, st) {
                          return Container(
                            decoration: const BoxDecoration(color: AppColors.darkGray),
                          );
                        },
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
                      Text("Ingredients", style: Theme.of(context).textTheme.headline4),
                      ListBody(
                        children: cocktail.ingredients.map((ingredient) {
                          return ListTile(
                            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                            title: Text([ingredient.name, ingredient.quantity?.toString(), ingredient.measurement]
                                .where((e) => e != null)
                                .join(" ")),
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
    }, error: (err, stack) {
      return const Scaffold(
        body: Center(child: Text('Internal error occurred')),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
