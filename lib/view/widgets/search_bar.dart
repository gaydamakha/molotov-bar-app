import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';

class SearchBar extends ConsumerWidget {
  final void Function(dynamic) onSubmitted;
  final String? filterDropdownTitle;
  final List<SelectedListItem>? listOfFilters;
  final Function(SelectedListItem?)? onSelect;

  const SearchBar({
    Key? key,
    required this.onSubmitted,
    this.filterDropdownTitle,
    this.listOfFilters,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var filterController = TextEditingController();
    final _inputController = TextEditingController();

    void onTextFieldTap() {
      DropDownState(
        DropDown(
            bottomSheetTitle: "Ingredients",
            searchBackgroundColor: Theme.of(context).colorScheme.primaryVariant,
            dataList: listOfFilters ?? [],
            enableMultipleSelection: false,
            searchController: filterController,
            selectedItem: onSelect),
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
                suffixIcon: listOfFilters == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: onTextFieldTap,
                      ))));
  }
}
