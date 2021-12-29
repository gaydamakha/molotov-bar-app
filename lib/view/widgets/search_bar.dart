import 'package:flutter/material.dart';
import 'package:molotov_bar/theme/app_colors.dart';

class SearchBar extends StatelessWidget {
  final void Function(dynamic) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 22.0),
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
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.tune),
            )));
  }
}
