// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i6;

import '../core/models/cocktail.dart' as _i7;
import '../home_page.dart' as _i1;
import '../view/pages/cocktail_detail_page.dart' as _i4;
import '../view/pages/cocktails_search_page.dart' as _i3;
import '../view/pages/favorites_list_page.dart' as _i5;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CocktailsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    FavoritesRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    CocktailsSearchRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.CocktailsSearchPage());
    },
    CocktailDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CocktailDetailRouteArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i4.CocktailDetailPage(key: args.key, cocktail: args.cocktail));
    },
    FavoritesListRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.FavoritesListPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(CocktailsRouter.name,
              path: 'cocktails',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(CocktailsSearchRoute.name,
                    path: '', parent: CocktailsRouter.name),
                _i2.RouteConfig(CocktailDetailRoute.name,
                    path: 'cocktail-detail-page', parent: CocktailsRouter.name)
              ]),
          _i2.RouteConfig(FavoritesRouter.name,
              path: 'favorites',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(FavoritesListRoute.name,
                    path: '', parent: FavoritesRouter.name),
                _i2.RouteConfig(CocktailDetailRoute.name,
                    path: 'cocktail-detail-page', parent: FavoritesRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class CocktailsRouter extends _i2.PageRouteInfo<void> {
  const CocktailsRouter({List<_i2.PageRouteInfo>? children})
      : super(CocktailsRouter.name,
            path: 'cocktails', initialChildren: children);

  static const String name = 'CocktailsRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class FavoritesRouter extends _i2.PageRouteInfo<void> {
  const FavoritesRouter({List<_i2.PageRouteInfo>? children})
      : super(FavoritesRouter.name,
            path: 'favorites', initialChildren: children);

  static const String name = 'FavoritesRouter';
}

/// generated route for
/// [_i3.CocktailsSearchPage]
class CocktailsSearchRoute extends _i2.PageRouteInfo<void> {
  const CocktailsSearchRoute() : super(CocktailsSearchRoute.name, path: '');

  static const String name = 'CocktailsSearchRoute';
}

/// generated route for
/// [_i4.CocktailDetailPage]
class CocktailDetailRoute extends _i2.PageRouteInfo<CocktailDetailRouteArgs> {
  CocktailDetailRoute({_i6.Key? key, required _i7.Cocktail cocktail})
      : super(CocktailDetailRoute.name,
            path: 'cocktail-detail-page',
            args: CocktailDetailRouteArgs(key: key, cocktail: cocktail));

  static const String name = 'CocktailDetailRoute';
}

class CocktailDetailRouteArgs {
  const CocktailDetailRouteArgs({this.key, required this.cocktail});

  final _i6.Key? key;

  final _i7.Cocktail cocktail;

  @override
  String toString() {
    return 'CocktailDetailRouteArgs{key: $key, cocktail: $cocktail}';
  }
}

/// generated route for
/// [_i5.FavoritesListPage]
class FavoritesListRoute extends _i2.PageRouteInfo<void> {
  const FavoritesListRoute() : super(FavoritesListRoute.name, path: '');

  static const String name = 'FavoritesListRoute';
}
