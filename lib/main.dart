import 'package:flutter/material.dart';
import 'package:molotov_bar/view/pages/cocktails_list_page.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MolotovBarApp());
}

class MolotovBarApp extends StatelessWidget {
  const MolotovBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CocktailsViewModel()),
      ],
      child: MaterialApp(
        title: 'Molotov.bar',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow)
              .copyWith(secondary: Colors.deepOrange),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const CocktailsListPage(title: 'Molotov Bar'),
        },
      ),
    );
  }
}
