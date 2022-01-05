import 'package:flutter/material.dart';

import 'package:molotov_bar/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    var theme = ThemeData(
      colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: AppColors.lightGray,
          secondary: AppColors.yellow),
      fontFamily: 'VisueltPro',
    );
    return theme.copyWith(
        textTheme: theme.textTheme.apply(
            displayColor: AppColors.lightGray, fontFamily: 'VisueltPro'));
  }
}
