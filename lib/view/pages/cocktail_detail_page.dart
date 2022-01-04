import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

class CocktailDetailPage extends StatelessWidget {
  final String name;

  const CocktailDetailPage({
    Key? key,
    @PathParam() required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("plop");
  }
}