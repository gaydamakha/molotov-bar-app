import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/providers/providers.dart';

class DropDown {
  /// This gives the button text or it sets default text as 'click me'.
  final String? buttonText;

  /// This gives the bottom sheet title.
  final String? bottomSheetTitle;

  /// This will give the submit button text.
  final String? submitButtonText;

  /// This will give the submit button background color.
  final Color? submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This will give the default search controller to the search text field.
  final TextEditingController searchController;

  final PagingController<int, SelectedListItem> _pagingController = PagingController(firstPageKey: 0);

  /// This will give the call back to the selected items (multiple) from list.
  final Function(List<dynamic>)? selectedItems;

  /// This will give the call back to the selected item (single) from list.
  final Function(SelectedListItem?)? selectedItem;

  /// This will give selection choise for single or multiple for list.
  final bool enableMultipleSelection;

  DropDown({
    Key? key,
    this.buttonText,
    this.bottomSheetTitle,
    this.submitButtonText,
    this.submitButtonColor,
    this.searchHintText,
    this.searchBackgroundColor,
    required this.searchController,
    this.selectedItems,
    this.selectedItem,
    required this.enableMultipleSelection,
  });
}

class DropDownState {
  DropDown dropDown;

  DropDownState(this.dropDown);

  /// This gives the bottom sheet widget.
  void showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(13.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MainBody(
              dropDown: dropDown,
            );
          },
        );
      },
    );
  }
}

/// This is Model class. Using this model class, you can add the list of data with title and its selection.
class SelectedListItem {
  bool isSelected;
  String name;

  SelectedListItem(this.isSelected, this.name);
}

/// This is main class to display the bottom sheet body.
class MainBody extends StatefulHookConsumerWidget {
  final DropDown dropDown;

  const MainBody({required this.dropDown, Key? key}) : super(key: key);

  @override
  ConsumerState<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  /// This list will set when the list of data is not available.
  static const int defaultIngredientsLimit = 10;

  String? _searchTerm;

  @override
  void initState() {
    super.initState();
    widget.dropDown._pagingController.addPageRequestListener((pageKey) {
      _fetchIngredients(pageKey);
    });
  }

  Future<void> _fetchIngredients(int pageKey) async {
    try {
      final newIngredients = await ref
          .read(ingredientRepositoryProvider)
          .getAll(defaultIngredientsLimit, offset: pageKey, keyword: _searchTerm);
      _appendIngredients(newIngredients, pageKey);
    } on Error catch (e) {
      _setError(e);
    }
  }

  void _search(String searchTerm) {
    _searchTerm = searchTerm;
    widget.dropDown._pagingController.refresh();
  }

  _appendIngredients(List<Ingredient> ingredients, int pageKey) {
    final selectableIngredients = ingredients.map((e) => SelectedListItem(false, e.name)).toList();
    final isLastPage = selectableIngredients.length < defaultIngredientsLimit;
    if (isLastPage) {
      widget.dropDown._pagingController.appendLastPage(selectableIngredients);
    } else {
      final nextPageKey = pageKey + ingredients.length;
      widget.dropDown._pagingController.appendPage(selectableIngredients, nextPageKey);
    }
  }

  _setError(Error cocktailError) {
    widget.dropDown._pagingController.error = cocktailError;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.13,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Bottom sheet title text
                  widget.dropDown.bottomSheetTitle != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(widget.dropDown.bottomSheetTitle!, style: Theme.of(context).textTheme.headline5),
                        )
                      : const SizedBox(),

                  /// Done button
                  Visibility(
                    visible: widget.dropDown.enableMultipleSelection,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            List<SelectedListItem> selectedList = widget.dropDown._pagingController.itemList
                                    ?.where((element) => element.isSelected)
                                    .toList() ??
                                [];
                            List<String> selectedNameList = [];

                            for (var element in selectedList) {
                              selectedNameList.add(element.name);
                            }

                            widget.dropDown.selectedItems?.call(selectedNameList);
                            _onUnfocusKeyboardAndPop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: widget.dropDown.submitButtonColor ?? Colors.blue,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(widget.dropDown.submitButtonText ?? 'Done')),
                    ),
                  ),
                ],
              ),
            ),

            /// A [TextField] that displays a list of suggestions as the user types with clear button.
            _AppTextField(
              dropDown: widget.dropDown,
              onTextChanged: _buildSearchList,
              onClearTap: _onClearTap,
            ),

            /// Listview (list of data with check box for multiple selection & on tile tap single selection)
            Expanded(
              child: PagedListView<int, SelectedListItem>(
                  pagingController: widget.dropDown._pagingController,
                  builderDelegate: PagedChildBuilderDelegate<SelectedListItem>(
                    itemBuilder: (context, item, index) {
                      return InkWell(
                        child: Container(
                          color: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: ListTile(
                                title: Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                trailing: widget.dropDown.enableMultipleSelection
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            item.isSelected = !item.isSelected;
                                          });
                                        },
                                        child: item.isSelected
                                            ? const Icon(Icons.check_box)
                                            : const Icon(Icons.check_box_outline_blank),
                                      )
                                    : item.isSelected
                                        ? Icon(Icons.check, color: Theme.of(context).colorScheme.secondary)
                                        : null),
                          ),
                        ),
                        onTap: widget.dropDown.enableMultipleSelection
                            ? null
                            : () {
                                setState(() {
                                  for (var otherItem in widget.dropDown._pagingController.itemList ?? []) {
                                    if (otherItem.name != widget.dropDown._pagingController.itemList?[index].name) {
                                      otherItem.isSelected = false;
                                    }
                                  }
                                  var item = widget.dropDown._pagingController.itemList?[index];
                                  if (item != null) {
                                    item.isSelected = !item.isSelected;
                                    if (item.isSelected) {
                                      widget.dropDown._pagingController.itemList
                                          ?.removeWhere((e) => e.name == item.name);
                                      widget.dropDown._pagingController.itemList
                                          ?.insert(0, SelectedListItem(true, item.name));
                                      widget.dropDown.selectedItem?.call(item);
                                      return;
                                    }
                                  }
                                  widget.dropDown.selectedItem?.call(null);
                                });
                                _onUnfocusKeyboardAndPop();
                              },
                      );
                    },
                  )),
            ),
          ],
        );
      },
    );
  }

  /// This helps when search enabled & show the filtered data in list.
  _buildSearchList(String userSearchTerm) {
    _search(userSearchTerm);
  }

  /// This helps when want to clear text in search text field.
  void _onClearTap() {
    _searchTerm = null;
    widget.dropDown.searchController.clear();
    widget.dropDown.selectedItem?.call(null);
    widget.dropDown._pagingController.refresh();
    setState(() {});
  }

  /// This helps to unfocus the keyboard & pop from the bottom sheet.
  _onUnfocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }
}

/// This is search text field class.
class _AppTextField extends StatefulWidget {
  DropDown dropDown;
  Function(String) onTextChanged;
  VoidCallback onClearTap;

  _AppTextField({required this.dropDown, required this.onTextChanged, required this.onClearTap, Key? key})
      : super(key: key);

  @override
  State<_AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<_AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 2),
      child: TextFormField(
        controller: widget.dropDown.searchController,
        onChanged: (value) {
          widget.onTextChanged(value);
        },
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.dropDown.searchBackgroundColor ?? Colors.black12,
          contentPadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
          hintText: widget.dropDown.searchHintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(13.0),
            ),
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            onTap: widget.onClearTap,
            child: const Icon(Icons.cancel),
          ),
        ),
      ),
    );
  }
}
