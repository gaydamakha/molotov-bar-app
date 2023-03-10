import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/theme/app_theme.dart';

void main() async {
  runApp(ProviderScope(child: MolotovBarApp()));
}

class MolotovBarApp extends StatelessWidget {
  MolotovBarApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Molotov.bar',
      theme: AppTheme.darkTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
