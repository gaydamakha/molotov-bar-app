// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i6;

import '../home_page.dart' as _i1;
import '../view/pages/cocktail_detail_page.dart' as _i5;
import '../view/pages/cocktails_list_page.dart' as _i4;
import '../view/pages/favorites_list_page.dart' as _i3;

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
          routeData: routeData, child: const _i3.FavoritesListPage());
    },
    CocktailsListRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CocktailsListPage());
    },
    CocktailDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CocktailDetailRouteArgs>(
          orElse: () =>
              CocktailDetailRouteArgs(drinkId: pathParams.getInt('drinkId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CocktailDetailPage(key: args.key, drinkId: args.drinkId));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(CocktailsRouter.name,
              path: 'cocktails',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(CocktailsListRoute.name,
                    path: '', parent: CocktailsRouter.name),
                _i2.RouteConfig(CocktailDetailRoute.name,
                    path: ':drinkId', parent: CocktailsRouter.name)
              ]),
          _i2.RouteConfig(FavoritesRouter.name,
              path: 'favorites', parent: HomeRoute.name)
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
/// [_i3.FavoritesListPage]
class FavoritesRouter extends _i2.PageRouteInfo<void> {
  const FavoritesRouter() : super(FavoritesRouter.name, path: 'favorites');

  static const String name = 'FavoritesRouter';
}

/// generated route for
/// [_i4.CocktailsListPage]
class CocktailsListRoute extends _i2.PageRouteInfo<void> {
  const CocktailsListRoute() : super(CocktailsListRoute.name, path: '');

  static const String name = 'CocktailsListRoute';
}

/// generated route for
/// [_i5.CocktailDetailPage]
class CocktailDetailRoute extends _i2.PageRouteInfo<CocktailDetailRouteArgs> {
  CocktailDetailRoute({_i6.Key? key, required int drinkId})
      : super(CocktailDetailRoute.name,
            path: ':drinkId',
            args: CocktailDetailRouteArgs(key: key, drinkId: drinkId),
            rawPathParams: {'drinkId': drinkId});

  static const String name = 'CocktailDetailRoute';
}

class CocktailDetailRouteArgs {
  const CocktailDetailRouteArgs({this.key, required this.drinkId});

  final _i6.Key? key;

  final int drinkId;

  @override
  String toString() {
    return 'CocktailDetailRouteArgs{key: $key, drinkId: $drinkId}';
  }
}
