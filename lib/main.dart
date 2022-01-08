import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:molotov_bar/core/repositories/cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/composite/composite_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/http/http_cocktail_repository.dart';
import 'package:molotov_bar/core/repositories/local/local_favorite_cocktail_repository.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/theme/app_theme.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:molotov_bar/view_models/favorite_cocktails_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt getIt = GetIt.instance;
  var dbStructure = await rootBundle.loadString('assets/sql/db.sql');
  var db = await openDatabase(
    'cocktails.db',
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(dbStructure);
    },
    version: 1,
  );

  getIt.registerSingleton<CocktailRepository>(CompositeCocktailRepository(
    HttpCocktailRepository(),
    LocalCocktailRepository(db),
  ));
  runApp(MolotovBarApp());
}

class MolotovBarApp extends StatelessWidget {
  MolotovBarApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CocktailsViewModel()),
          ChangeNotifierProvider(create: (_) => FavoriteCocktailsViewModel())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Molotov.bar',
          theme: AppTheme.darkTheme,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ));
  }
}
