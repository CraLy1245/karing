import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

abstract final class KaringPreviewTheme {
  static const Color _brand = Color(0xFF2563EB);

  static ThemeData light() {
    return _build(Brightness.light, KaringThemeExtension.light);
  }

  static ThemeData dark() {
    return _build(Brightness.dark, KaringThemeExtension.dark);
  }

  static ThemeData _build(
    Brightness brightness,
    KaringThemeExtension extension,
  ) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _brand,
      brightness: brightness,
    ).copyWith(surface: extension.panelBackground);

    final outline = extension.subtleBorder;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: extension.appBackground,
      extensions: <ThemeExtension<dynamic>>[extension],
      dividerColor: outline,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: extension.appBackground,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: extension.panelBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: outline),
          borderRadius: BorderRadius.circular(KaringRadius.lg),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: extension.panelBackground,
        indicatorColor: scheme.primaryContainer,
        useIndicator: true,
        labelType: NavigationRailLabelType.all,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: extension.panelBackground,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: extension.subtleSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KaringSpacing.lg,
          vertical: KaringSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: KaringSpacing.xl,
            vertical: KaringSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(44, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: KaringSpacing.xl,
            vertical: KaringSpacing.md,
          ),
          side: BorderSide(color: outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(44, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return extension.subtleBorder;
        }),
        thumbColor: const WidgetStatePropertyAll(Colors.white),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 350),
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(KaringRadius.sm),
        ),
        textStyle: TextStyle(color: scheme.onInverseSurface),
      ),
    );
  }
}
