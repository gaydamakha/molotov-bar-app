import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

class CocktailDetailPage extends StatelessWidget {
  final int drinkId;

  const CocktailDetailPage({
    Key? key,
    @PathParam() required this.drinkId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("plop");
  }
}