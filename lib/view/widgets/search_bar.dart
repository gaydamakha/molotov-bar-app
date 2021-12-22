import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function(dynamic) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();

    return TextField( //TODO: make it more sexy
        style: const TextStyle(
          fontSize: 15.0,
          color: Colors.grey,
        ),
        controller: _inputController,
        onChanged: (value) {},
        onSubmitted: (value) => onSubmitted(value),
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: 'Enter cocktail name',
        ));
  }
}