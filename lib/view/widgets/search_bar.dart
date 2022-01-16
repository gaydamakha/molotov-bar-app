import 'package:flutter/material.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';

class SearchBar extends StatelessWidget {
  final void Function(dynamic) onSubmitted;
  final String? filterDropdownTitle;
  final List<String>? listOfFilters;

  const SearchBar(
      {Key? key,
      required this.onSubmitted,
      this.filterDropdownTitle,
      this.listOfFilters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterController = TextEditingController();
    final _inputController = TextEditingController();

    void onTextFieldTap() {
      DropDownState(
        DropDown(
          bottomSheetTitle: "Ingredients",
          searchBackgroundColor: Theme.of(context).colorScheme.primaryVariant,
          dataList: listOfFilters!.map((e) => SelectedListItem(false, e)).toList(),
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
                suffixIcon: listOfFilters == null ? null : IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: onTextFieldTap,
                ))));
  }
}
