import 'package:flutter/widgets.dart';

abstract final class KaringSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
}

abstract final class KaringRadius {
  static const double xs = 6;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;
}

abstract final class KaringMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration emphasized = Duration(milliseconds: 320);
}

abstract final class KaringBreakpoints {
  static const double compact = 600;
  static const double medium = 900;
  static const double expanded = 1200;
}

abstract final class KaringLayout {
  static const double contentMaxWidth = 1080;
  static const double settingsMaxWidth = 840;
  static const double desktopNavigationWidth = 240;
}

abstract final class KaringInsets {
  static const EdgeInsets pageCompact = EdgeInsets.symmetric(
    horizontal: KaringSpacing.lg,
    vertical: KaringSpacing.lg,
  );

  static const EdgeInsets pageExpanded = EdgeInsets.symmetric(
    horizontal: KaringSpacing.xxxl,
    vertical: KaringSpacing.xxl,
  );

  static const EdgeInsets card = EdgeInsets.all(KaringSpacing.lg);
}
