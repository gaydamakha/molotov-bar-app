import 'package:auto_route/auto_route.dart';
import 'package:molotov_bar/home_page.dart';
import 'package:molotov_bar/view/pages/cocktail_detail_page.dart';
import 'package:molotov_bar/view/pages/cocktails_list_by_ingredient_page.dart';
import 'package:molotov_bar/view/pages/cocktails_list_page.dart';
import 'package:molotov_bar/view/pages/favorites_list_page.dart';
import 'package:molotov_bar/view/pages/ingredients_list_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/', page: HomePage, children: [
      AutoRoute(
        path: 'cocktails',
        name: 'CocktailsRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            page: CocktailsListPage,
          ),
          AutoRoute(
            path: ':drinkId',
            page: CocktailDetailPage,
          )
        ],
      ),
      AutoRoute(
        path: 'ingredients',
        name: 'IngredientsRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            page: IngredientsListPage,
          ),
          AutoRoute(
            path: ':id',
            page: CocktailsListByIngredientPage,
          ),
        ],
      ),
      AutoRoute(
        path: 'favorites',
        name: 'FavoritesRouter',
        page: FavoritesListPage,
      )
    ]),
  ],
)
class $AppRouter {}