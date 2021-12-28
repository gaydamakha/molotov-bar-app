import 'package:flutter/material.dart';
import 'package:molotov_bar/theme/app_theme.dart';
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
        theme: AppTheme.darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const CocktailsListPage(title: 'Molotov Bar'),
        },
      ),
    );
  }
}
