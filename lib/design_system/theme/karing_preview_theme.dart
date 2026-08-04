import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

/// Production theme for the redesigned Karing interface.
///
/// Business screens should consume [Theme.of] and semantic colors from
/// [KaringThemeExtension] rather than declaring page-specific colors.
abstract final class KaringTheme {
  static const Color brand = Color(0xFF2563EB);

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
      seedColor: brand,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      surface: extension.appBackground,
      surfaceContainerLowest: extension.panelBackground,
      surfaceContainerLow: extension.panelBackground,
      surfaceContainer: extension.subtleSurface,
      surfaceContainerHigh: extension.subtleSurface,
      outline: extension.subtleBorder,
      outlineVariant: extension.subtleBorder,
      error: extension.danger,
      errorContainer: extension.dangerContainer,
    );

    final textTheme = Typography.material2021(
      platform: TargetPlatform.android,
    ).black.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: extension.appBackground,
      canvasColor: extension.appBackground,
      extensions: <ThemeExtension<dynamic>>[extension],
      visualDensity: VisualDensity.standard,
      textTheme: textTheme.copyWith(
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        titleSmall: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerColor: extension.subtleBorder,
      dividerTheme: DividerThemeData(
        color: extension.subtleBorder,
        thickness: 0.7,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: extension.appBackground,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.symmetric(
          horizontal: KaringSpacing.md,
          vertical: KaringSpacing.xs,
        ),
        color: extension.panelBackground,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: extension.subtleBorder),
          borderRadius: BorderRadius.circular(KaringRadius.lg),
        ),
      ),
      listTileTheme: ListTileThemeData(
        minTileHeight: 52,
        minVerticalPadding: KaringSpacing.sm,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KaringSpacing.lg,
          vertical: KaringSpacing.xs,
        ),
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: extension.panelBackground,
        indicatorColor: scheme.primaryContainer,
        useIndicator: true,
        labelType: NavigationRailLabelType.all,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: extension.panelBackground,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: extension.subtleSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KaringSpacing.lg,
          vertical: KaringSpacing.md,
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: scheme.primary),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
        errorStyle: TextStyle(color: extension.danger),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: extension.subtleBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: extension.subtleBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: extension.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
          borderSide: BorderSide(color: extension.danger, width: 1.5),
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
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(44, 48),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: KaringSpacing.xl,
            vertical: KaringSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
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
          side: BorderSide(color: extension.subtleBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(44, 44),
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
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KaringRadius.xs),
        ),
        side: BorderSide(color: extension.subtleBorder, width: 1.5),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: extension.subtleSurface,
        circularTrackColor: extension.subtleSurface,
        strokeWidth: 2.5,
      ),
      dialogTheme: DialogThemeData(
        elevation: 0,
        backgroundColor: extension.panelBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: extension.subtleBorder),
          borderRadius: BorderRadius.circular(KaringRadius.xl),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        modalElevation: 0,
        backgroundColor: extension.panelBackground,
        modalBackgroundColor: extension.panelBackground,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(KaringRadius.xl),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 4,
        color: extension.panelBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: extension.subtleBorder),
          borderRadius: BorderRadius.circular(KaringRadius.md),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KaringRadius.md),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: KaringMotion.standard,
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(KaringRadius.sm),
        ),
        textStyle: TextStyle(color: scheme.onInverseSurface),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}

/// Kept for the isolated preview entry and external references created in phase 1.
abstract final class KaringPreviewTheme {
  static ThemeData light() => KaringTheme.light();
  static ThemeData dark() => KaringTheme.dark();
}
