import 'package:calcy/theme/text_theme.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CalcyTheme {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CalcyColors.back,
      surface: CalcyColors.back,
    ),
    textTheme: calcyTextTheme,
    iconTheme: IconThemeData(color: CalcyColors.white, size: 35),
  );
}

extension BuildContextConversion on BuildContext {
  ColorScheme get getColorScheme => Theme.of(this).colorScheme;
  TextTheme get getTextTheme => Theme.of(this).textTheme;
  IconThemeData get getIconTheme => Theme.of(this).iconTheme;
}
