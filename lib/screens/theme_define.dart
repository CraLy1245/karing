import 'package:flutter/material.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

class ThemeDefine {
  static const MaterialColor kColorBlue =
      MaterialColor(0xFF2563EB, <int, Color>{
        50: Color(0xFFEFF6FF),
        100: Color(0xFFDBEAFE),
        200: Color(0xFFBFDBFE),
        300: Color(0xFF93C5FD),
        400: Color(0xFF60A5FA),
        500: Color(0xFF3B82F6),
        600: Color(0xFF2563EB),
        700: Color(0xFF1D4ED8),
        800: Color(0xFF1E40AF),
        900: Color(0xFF1E3A8A),
      });
  static const kColorGrey = Colors.grey;
  static const kColorGreenBright = Color(0xFF22C55E);

  static const String kThemeSystem = "system";
  static const String kThemeLight = "light";
  static const String kThemeDark = "dark";

  static const BorderRadiusGeometry kBorderRadius = BorderRadius.all(
    Radius.circular(KaringRadius.md),
  );
}
