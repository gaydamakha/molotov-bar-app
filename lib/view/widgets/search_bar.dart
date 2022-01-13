import 'package:flutter/material.dart';
import 'package:molotov_bar/theme/app_colors.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';

class SearchBar extends StatelessWidget {
  final void Function(dynamic) onSubmitted;

  SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  final List<SelectedListItem> listOfIngredients = [
    SelectedListItem(false, "Vodka")
  ];

  @override
  Widget build(BuildContext context) {


    var filterController = TextEditingController();
    final _inputController = TextEditingController();

    void onTextFieldTap() {
      DropDownState(
        DropDown(
          searchHintText: "search..",
          bottomSheetTitle: "filters",
          searchBackgroundColor: Colors.black12,

          dataList: listOfIngredients,
          selectedItem: (String selected) {
            filterController.text = selected;
          },
          enableMultipleSelection: false,
          searchController: filterController,
        ),
      ).showModal(context);
    }


    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.0),
          color: AppColors.gray,
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
              suffixIcon: GestureDetector(
                onTap: onTextFieldTap,
                child: const Icon(Icons.tune),
              ),
            )));
  }
}
