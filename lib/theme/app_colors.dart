import 'package:flutter/material.dart';

class AppColors {
  static const dark = Color(0xff2b2b2b);
  static const yellow = Color(0xffebb56d);
  static const lightGray = Color(0xff3c3f41);
  static const darkGray = Color(0xff1d1d1d);
  static MaterialColor materialDark = createMaterialColor(dark);
  static MaterialColor materialYellow = createMaterialColor(yellow);
  static MaterialColor materialLightGray = createMaterialColor(lightGray);
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
