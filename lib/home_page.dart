import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molotov_bar/routes/router.gr.dart';
import 'package:molotov_bar/theme/app_colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        CocktailsRouter(),
        FavoritesRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          color: AppColors.darkGray,
            child: SalomonBottomBar(
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 10,
          ),
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                FontAwesomeIcons.cocktail,
                size: 25,
              ),
              title: const Text('Cocktails'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.favorite,
                size: 25,
              ),
              title: const Text('Favorites'),
            )
          ],
        ));
      },
    );
  }
}
