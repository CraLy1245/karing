import 'package:flutter/material.dart';

@immutable
class KaringThemeExtension extends ThemeExtension<KaringThemeExtension> {
  const KaringThemeExtension({
    required this.appBackground,
    required this.panelBackground,
    required this.subtleSurface,
    required this.subtleBorder,
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.danger,
    required this.dangerContainer,
    required this.upload,
    required this.download,
  });

  final Color appBackground;
  final Color panelBackground;
  final Color subtleSurface;
  final Color subtleBorder;
  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color danger;
  final Color dangerContainer;
  final Color upload;
  final Color download;

  static const KaringThemeExtension light = KaringThemeExtension(
    appBackground: Color(0xFFF6F7F9),
    panelBackground: Color(0xFFFFFFFF),
    subtleSurface: Color(0xFFF0F2F5),
    subtleBorder: Color(0xFFE1E5EA),
    success: Color(0xFF15803D),
    successContainer: Color(0xFFE9F8EE),
    warning: Color(0xFFB45309),
    warningContainer: Color(0xFFFFF4DF),
    danger: Color(0xFFDC2626),
    dangerContainer: Color(0xFFFDECEC),
    upload: Color(0xFF7C3AED),
    download: Color(0xFF0284C7),
  );

  static const KaringThemeExtension dark = KaringThemeExtension(
    appBackground: Color(0xFF0E1116),
    panelBackground: Color(0xFF171B22),
    subtleSurface: Color(0xFF202630),
    subtleBorder: Color(0xFF2B3340),
    success: Color(0xFF4ADE80),
    successContainer: Color(0xFF173825),
    warning: Color(0xFFFBBF24),
    warningContainer: Color(0xFF3A2D12),
    danger: Color(0xFFF87171),
    dangerContainer: Color(0xFF3B1D20),
    upload: Color(0xFFC4B5FD),
    download: Color(0xFF7DD3FC),
  );

  @override
  KaringThemeExtension copyWith({
    Color? appBackground,
    Color? panelBackground,
    Color? subtleSurface,
    Color? subtleBorder,
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? danger,
    Color? dangerContainer,
    Color? upload,
    Color? download,
  }) {
    return KaringThemeExtension(
      appBackground: appBackground ?? this.appBackground,
      panelBackground: panelBackground ?? this.panelBackground,
      subtleSurface: subtleSurface ?? this.subtleSurface,
      subtleBorder: subtleBorder ?? this.subtleBorder,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      danger: danger ?? this.danger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      upload: upload ?? this.upload,
      download: download ?? this.download,
    );
  }

  @override
  KaringThemeExtension lerp(covariant KaringThemeExtension? other, double t) {
    if (other is! KaringThemeExtension) {
      return this;
    }
    return KaringThemeExtension(
      appBackground: Color.lerp(appBackground, other.appBackground, t)!,
      panelBackground: Color.lerp(panelBackground, other.panelBackground, t)!,
      subtleSurface: Color.lerp(subtleSurface, other.subtleSurface, t)!,
      subtleBorder: Color.lerp(subtleBorder, other.subtleBorder, t)!,
      success: Color.lerp(success, other.success, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerContainer: Color.lerp(dangerContainer, other.dangerContainer, t)!,
      upload: Color.lerp(upload, other.upload, t)!,
      download: Color.lerp(download, other.download, t)!,
    );
  }
}

extension KaringThemeContext on BuildContext {
  KaringThemeExtension get karingTheme {
    return Theme.of(this).extension<KaringThemeExtension>() ??
        KaringThemeExtension.light;
  }
}
