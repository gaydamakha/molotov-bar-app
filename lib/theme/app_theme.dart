import 'package:flutter/material.dart';

import 'package:molotov_bar/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    var theme = ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.lightGray,
        secondary: AppColors.yellow,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.lightGray,
      backgroundColor: AppColors.dark,
      scaffoldBackgroundColor: AppColors.dark,
    );
    return theme.copyWith(
      textTheme: theme.textTheme
          .apply(displayColor: AppColors.lightGray, fontFamily: 'VisueltPro'),
    );
  }
}
