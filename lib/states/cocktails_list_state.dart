import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:molotov_bar/core/models/cocktail.dart';
import 'package:molotov_bar/core/models/cocktail_error.dart';

part 'cocktails_list_state.freezed.dart';

@freezed
class CocktailsListState with _$CocktailsListState {
  const factory CocktailsListState({
    @Default(true) bool isLoading,
    @Default(null) CocktailError? error,
    @Default({}) Map<String, Cocktail> cocktails,
  }) = _CocktailsListState;
}
