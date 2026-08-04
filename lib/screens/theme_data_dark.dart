import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_preview_theme.dart';

class ThemeDataDark {
  static const Color mainColor = Color(0xFF171B22);
  static const Color mainBgColor = Color(0xFF0E1116);

  static ThemeData theme(BuildContext context) {
    return KaringTheme.dark();
  }
}
