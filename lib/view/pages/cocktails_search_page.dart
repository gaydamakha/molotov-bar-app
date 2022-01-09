import 'package:flutter/material.dart';
import 'package:molotov_bar/view/widgets/cocktails_list.dart';
import 'package:molotov_bar/view/widgets/search_bar.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';

class CocktailsSearchPage extends StatefulWidget {
  const CocktailsSearchPage({Key? key}) : super(key: key);

  @override
  State<CocktailsSearchPage> createState() => _CocktailsSearchPageState();
}

class _CocktailsSearchPageState extends State<CocktailsSearchPage> {
  @override
  Widget build(BuildContext context) {
    CocktailsViewModel cocktailsViewModel = context.watch<CocktailsViewModel>();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 10,
      ),
      child: Column(children: <Widget>[
        SearchBar(onSubmitted: (value) {
          if (value.isNotEmpty) {
            cocktailsViewModel.searchCocktails(value);
          }
        }),
        const SizedBox(height: 10),
        Flexible(child: _ui(cocktailsViewModel)),
      ]),
    )));
  }

  Widget _ui(CocktailsViewModel cocktailsViewModel) {
    if (cocktailsViewModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (cocktailsViewModel.cocktailError != null) {
      return Text(cocktailsViewModel.cocktailError!.message);
    }
    return CocktailsList(cocktailsList: cocktailsViewModel.getCocktails());
  }
}
