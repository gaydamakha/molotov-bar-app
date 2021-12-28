import 'package:flutter/material.dart';

import 'package:molotov_bar/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: AppColors.materialDark,
          accentColor: AppColors.materialYellow,
        ),
        fontFamily: 'Montserrat',
    );
  }
}
