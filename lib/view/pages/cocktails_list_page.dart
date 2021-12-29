import 'package:flutter/material.dart';
import 'package:molotov_bar/core/model_data.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/view/widgets/cocktail_tile.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

import 'cocktail_detail_page.dart';

class CocktailsListPage extends StatefulWidget {
  const CocktailsListPage({Key? key}) : super(key: key);

  @override
  State<CocktailsListPage> createState() => _CocktailsListPageState();
}

class _CocktailsListPageState extends State<CocktailsListPage> {
  Widget getCocktailsWidget(BuildContext context, ModelData modelData) {
    List<Cocktail>? cocktailsList = modelData.data as List<Cocktail>?;
    switch (modelData.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TODO cocktail preview widget
            Text(cocktailsList!.length.toString()),
    CocktailTile(name: "Punch à la mirabelle",
      imageUrl: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
      onTileTap: () => context.router.push(CocktailDetailRoute(drinkId: 1)),
    ),
          ],
          // children: [
          //   Expanded(
          //     // flex: 8,
          //     // child: PlayerListWidget(cocktailsList!, (Media media) {
          //     //   Provider.of<MediaViewModel>(context, listen: false)
          //     //       .setSelectedMedia(media);
          //     // }),
          //   ),
          //   Expanded(
          //     flex: 2,
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: PlayerWidget(
          //         function: () {
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //   ),
          // ],
        );
      case Status.error:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.initial:
      default:
        return const Center(
          child: Text('Search the cocktail by name'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    ModelData modelData = Provider.of<CocktailsViewModel>(context).modelData;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(50),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: SearchBar(onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          Provider.of<CocktailsViewModel>(context,
                                  listen: false)
                              .setSelectedCocktail(null);
                          Provider.of<CocktailsViewModel>(context,
                                  listen: false)
                              .fetchCocktailsData(value);
                        }
                      })),
                ),
              ],
            ),
          ),
          Expanded(child: getCocktailsWidget(context, modelData)),
        ],
      )
    );
  }
}
