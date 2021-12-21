import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molotov_bar/core/model_data.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';
import 'package:provider/provider.dart';

class CocktailsListPage extends StatefulWidget {
  const CocktailsListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CocktailsListPage> createState() => _CocktailsListPageState();
}

class _CocktailsListPageState extends State<CocktailsListPage> {

  Widget getCocktailsWidget(BuildContext context, ModelData modelData) {
    List<Cocktail>? cocktailsList = modelData.data as List<Cocktail>?;
    switch (modelData.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.completed:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TODO cocktail preview widget
            Text(cocktailsList!.length.toString()),
          ],
          // children: [
          //   Expanded(
          //     // flex: 8,
          //     // child: PlayerListWidget(cocktailsList!, (Media media) {
          //     //   Provider.of<MediaViewModel>(context, listen: false)
          //     //       .setSelectedMedia(media);
          //     // }),
          //   ),
          //   Expanded(
          //     flex: 2,
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: PlayerWidget(
          //         function: () {
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //   ),
          // ],
        );
      case Status.error:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.initial:
      default:
        return const Center(
          child: Text('Search the cocktail by name'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ModelData modelData = Provider.of<CocktailsViewModel>(context).modelData;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField( //TODO: make it more sexy
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                        controller: _inputController,
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            Provider.of<CocktailsViewModel>(context, listen: false)
                                .setSelectedCocktail(null);
                            Provider.of<CocktailsViewModel>(context, listen: false)
                                .fetchCocktailsData(value);
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter cocktail name',
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getCocktailsWidget(context, modelData)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cocktail),
            label: "Cocktails",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
