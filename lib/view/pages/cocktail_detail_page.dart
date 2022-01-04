import 'package:flutter/material.dart';
import 'package:molotov_bar/core/models/cocktail.dart';

class CocktailDetailPage extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailPage({
    Key? key,
    required this.cocktail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(cocktail.imageUrl),
                  fit: BoxFit.cover,
                ),
              )
          )
      ),
    );
  }
}
