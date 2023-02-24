import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/providers/providers.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'cocktail_tile.dart';

class FavoriteCocktailsListView extends StatefulHookConsumerWidget {
  const FavoriteCocktailsListView({Key? key}) : super(key: key);

  @override
  _CocktailsListViewState createState() => _CocktailsListViewState();
}

class _CocktailsListViewState extends ConsumerState<FavoriteCocktailsListView> {
  @override
  Widget build(BuildContext context) => PagedGridView<int, Cocktail>(
        pagingController: ref.watch(favoriteCocktailsViewModelProvider.notifier).getPagingController(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<Cocktail>(
          itemBuilder: (context, item, index) => CocktailTile(
            name: item.name,
            imageUrl: item.imageUrl,
            onTileTap: () => context.router.push(CocktailDetailRoute(cocktailId: item.id)),
          ),
        ),
        //TODO: customize if nothing is found
        //           ?
        //           : Expanded(
        //               child: Center(
        //                 child: Text(
        //                   'Ops... nothing found!',
        //                   style: Theme.of(context).textTheme.headline6,
        //                 ),
        //               ),
        //             ),
      );
}
