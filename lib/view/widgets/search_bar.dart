import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:molotov_bar/core/models/ingredient.dart';
import 'package:molotov_bar/providers/providers.dart';
import 'package:molotov_bar/view/widgets/drop_down.dart';
import 'package:molotov_bar/view_models/cocktails_view_model.dart';

class SearchBar extends StatefulHookConsumerWidget {
  final void Function(String?) onSubmitted;
  final String? filterDropdownTitle;
  final Function(SelectedListItem?)? onSelect;

  const SearchBar({
    Key? key,
    required this.onSubmitted,
    this.filterDropdownTitle,
    this.onSelect,
  }) : super(key: key);

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  static const int defaultIngredientsLimit = 10;
  final PagingController<int, SelectedListItem> _pagingController = PagingController(firstPageKey: 0);
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchIngredients(pageKey);
    });
    _inputController.addListener(() {
      if (_inputController.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
    _fetchIngredients(_pagingController.firstPageKey);
    super.initState();
  }

  Future<void> _fetchIngredients(int pageKey) async {
    try {
      final newIngredients =
          await ref.read(ingredientRepositoryProvider).getAll(defaultIngredientsLimit, offset: pageKey);
      _appendIngredients(newIngredients, pageKey);
    } on Error catch (e) {
      _setError(e);
    }
  }

  _appendIngredients(List<Ingredient> ingredients, int pageKey) {
    final selectableIngredients = ingredients.map((e) => SelectedListItem(false, e.name)).toList();
    final isLastPage = selectableIngredients.length < defaultIngredientsLimit;
    if (isLastPage) {
      _pagingController.appendLastPage(selectableIngredients);
    } else {
      final nextPageKey = pageKey + ingredients.length;
      _pagingController.appendPage(selectableIngredients, nextPageKey);
    }
  }

  _setError(Error cocktailError) {
    _pagingController.error = cocktailError;
  }

  @override
  Widget build(BuildContext context) {
    final CocktailsViewModel cocktailsViewModel = ref.watch(cocktailsViewModelProvider.notifier);
    final String? selectedIngredient = cocktailsViewModel.ingredient;
    if (selectedIngredient != null) {
      _pagingController.itemList?.removeWhere((e) => e.name == selectedIngredient);
      _pagingController.itemList?.insert(0, SelectedListItem(true, selectedIngredient));
    }
    void onTextFieldTap() {
      DropDownState(
        DropDown(
          bottomSheetTitle: "Ingredients",
          searchBackgroundColor: Theme.of(context).colorScheme.primaryVariant,
          dataList: _pagingController.itemList ?? [],
          //TODO: replace by PagedListView
          enableMultipleSelection: false,
          searchController: _filterController,
          selectedItem: widget.onSelect,
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
                    : _pagingController.itemList == null
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: onTextFieldTap,
                          ))));
  }
}
