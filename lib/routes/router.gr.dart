// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i8;

import '../home_page.dart' as _i1;
import '../view/pages/cocktail_detail_page.dart' as _i5;
import '../view/pages/cocktails_list_by_ingredient_page.dart' as _i7;
import '../view/pages/cocktails_list_page.dart' as _i4;
import '../view/pages/favorites_list_page.dart' as _i3;
import '../view/pages/ingredients_list_page.dart' as _i6;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
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
    IngredientsRouter.name: (routeData) {
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
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<CocktailDetailRouteArgs>(
          orElse: () =>
              CocktailDetailRouteArgs(drinkId: pathParams.getInt('drinkId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.CocktailDetailPage(key: args.key, drinkId: args.drinkId));
    },
    IngredientsListRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.IngredientsListPage());
    },
    CocktailsListByIngredientRoute.name: (routeData) {
      final pathParams = routeData.pathParams;
      final args = routeData.argsAs<CocktailsListByIngredientRouteArgs>(
          orElse: () =>
              CocktailsListByIngredientRouteArgs(id: pathParams.getInt('id')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CocktailsListByIngredientPage(key: args.key, id: args.id));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(CocktailsRouter.name, path: 'cocktails', children: [
            _i2.RouteConfig(CocktailsListRoute.name, path: ''),
            _i2.RouteConfig(CocktailDetailRoute.name, path: ':drinkId')
          ]),
          _i2.RouteConfig(IngredientsRouter.name,
              path: 'ingredients',
              children: [
                _i2.RouteConfig(IngredientsListRoute.name, path: ''),
                _i2.RouteConfig(CocktailsListByIngredientRoute.name,
                    path: ':id')
              ]),
          _i2.RouteConfig(FavoritesRouter.name, path: 'favorites')
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.EmptyRouterPage]
class CocktailsRouter extends _i2.PageRouteInfo<void> {
  const CocktailsRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'cocktails', initialChildren: children);

  static const String name = 'CocktailsRouter';
}

/// generated route for [_i2.EmptyRouterPage]
class IngredientsRouter extends _i2.PageRouteInfo<void> {
  const IngredientsRouter({List<_i2.PageRouteInfo>? children})
      : super(name, path: 'ingredients', initialChildren: children);

  static const String name = 'IngredientsRouter';
}

/// generated route for [_i3.FavoritesListPage]
class FavoritesRouter extends _i2.PageRouteInfo<void> {
  const FavoritesRouter() : super(name, path: 'favorites');

  static const String name = 'FavoritesRouter';
}

/// generated route for [_i4.CocktailsListPage]
class CocktailsListRoute extends _i2.PageRouteInfo<void> {
  const CocktailsListRoute() : super(name, path: '');

  static const String name = 'CocktailsListRoute';
}

/// generated route for [_i5.CocktailDetailPage]
class CocktailDetailRoute extends _i2.PageRouteInfo<CocktailDetailRouteArgs> {
  CocktailDetailRoute({_i8.Key? key, required int drinkId})
      : super(name,
            path: ':drinkId',
            args: CocktailDetailRouteArgs(key: key, drinkId: drinkId),
            rawPathParams: {'drinkId': drinkId});

  static const String name = 'CocktailDetailRoute';
}

class CocktailDetailRouteArgs {
  const CocktailDetailRouteArgs({this.key, required this.drinkId});

  final _i8.Key? key;

  final int drinkId;
}

/// generated route for [_i6.IngredientsListPage]
class IngredientsListRoute extends _i2.PageRouteInfo<void> {
  const IngredientsListRoute() : super(name, path: '');

  static const String name = 'IngredientsListRoute';
}

/// generated route for [_i7.CocktailsListByIngredientPage]
class CocktailsListByIngredientRoute
    extends _i2.PageRouteInfo<CocktailsListByIngredientRouteArgs> {
  CocktailsListByIngredientRoute({_i8.Key? key, required int id})
      : super(name,
            path: ':id',
            args: CocktailsListByIngredientRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'CocktailsListByIngredientRoute';
}

class CocktailsListByIngredientRouteArgs {
  const CocktailsListByIngredientRouteArgs({this.key, required this.id});

  final _i8.Key? key;

  final int id;
}
