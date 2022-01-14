import 'package:flutter/material.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';

class SearchBar extends StatelessWidget {
  final void Function(dynamic) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SelectedListItem> listOfIngredients = [
      SelectedListItem(false, "Vodka"),
      SelectedListItem(false, "Tequila")
    ];

    var filterController = TextEditingController();
    final _inputController = TextEditingController();

    void onTextFieldTap() {
      DropDownState(
        DropDown(
          bottomSheetTitle: "Ingredients",
          searchBackgroundColor: Theme.of(context).colorScheme.primaryVariant,
          dataList: listOfIngredients,
          enableMultipleSelection: false,
          searchController: filterController,
        ),
      ).showModal(context);
    }

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
        child: TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlignVertical: TextAlignVertical.center,
            controller: _inputController,
            onChanged: (value) {},
            onSubmitted: (value) => onSubmitted(value),
            decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: onTextFieldTap,
                ))));
  }
}
