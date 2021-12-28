import 'package:flutter/material.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/theme/app_theme.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MolotovBarApp());
}

class MolotovBarApp extends StatelessWidget {
  MolotovBarApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: CocktailsViewModel()),
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
