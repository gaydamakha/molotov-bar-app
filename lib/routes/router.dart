import 'package:auto_route/auto_route.dart';
import 'package:molotov_bar/home_page.dart';
import 'package:molotov_bar/view/pages/cocktail_detail_page.dart';
import 'package:molotov_bar/view/pages/cocktails_search_page.dart';
import 'package:molotov_bar/view/pages/favorites_list_page.dart';

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
            page: CocktailsSearchPage,
          ),
          AutoRoute(
            path: ':name',
            page: CocktailDetailPage,
          )
        ],
      ),
      AutoRoute(
        path: 'favorites',
        name: 'FavoritesRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            page: FavoritesListPage,
          ),
          AutoRoute(
            path: ':name',
            page: CocktailDetailPage,
          )
        ]
      )
    ]),
  ],
)
class $AppRouter {}