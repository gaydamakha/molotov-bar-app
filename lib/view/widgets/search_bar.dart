import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';

class SearchBar extends StatefulHookConsumerWidget {
  final void Function(String?) onSubmitted;
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
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  bool _isSearching = false;

  _SearchBarState() {
    _inputController.addListener(() {
      if (_inputController.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      }
      else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void onTextFieldTap() {
      DropDownState(
        DropDown(
            bottomSheetTitle: "Ingredients",
            searchBackgroundColor: Theme.of(context).colorScheme.primaryVariant,
            dataList: widget.listOfFilters ?? [],
            enableMultipleSelection: false,
            searchController: _filterController,
            selectedItem: widget.onSelect),
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
            onChanged: (value) {
            },
            onSubmitted: (value) => widget.onSubmitted(value),
            decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearching
                    ? IconButton(
                        onPressed: () {
                          _inputController.clear();
                          widget.onSubmitted(null);
                        },
                        icon: const Icon(Icons.cancel))
                    : widget.listOfFilters == null
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: onTextFieldTap,
                          ))));
  }
}
