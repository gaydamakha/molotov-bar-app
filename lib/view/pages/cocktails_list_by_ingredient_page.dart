import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

class CocktailsListByIngredientPage extends StatelessWidget {
  final int id;

  const CocktailsListByIngredientPage({
    Key? key,
    @PathParam() required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("plop");
  }
}