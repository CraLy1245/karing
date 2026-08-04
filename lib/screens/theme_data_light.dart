import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_preview_theme.dart';

class ThemeDataLight {
  static const Color mainColor = Colors.white;
  static const Color mainBgColor = Color(0xFFF6F7F9);

  static ThemeData theme(BuildContext context) {
    return KaringTheme.light();
  }
}
