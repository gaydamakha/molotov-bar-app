import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: Colors.amberAccent,
      routes: const [
        CocktailsRouter(),
        FavoritesRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return SalomonBottomBar(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            SalomonBottomBarItem(
              selectedColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.cocktail,
                size: 30,
              ),
              title: const Text('Cocktails'),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.black,
              icon: const Icon(
                Icons.favorite,
                size: 30,
              ),
              title: const Text('Favorites'),
            )
          ],
        );
      },
    );
  }
}
/*    return MultiProvider(
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
    );*/