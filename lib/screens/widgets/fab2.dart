// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

/// Connection dock used by the home screen.
///
/// The public API is intentionally kept compatible with the former convex
/// painter implementation so the VPN and server-selection code does not need
/// to change during the visual migration.
class ConvexButton2 extends StatelessWidget {
  static const _DEFAULT_SIZE = 64.0;
  static const _DEFAULT_THICKNESS = 72.0;

  final double? size;
  final double? top;
  final double? thickness;
  final double? sigma;
  final Widget child;
  final Widget? child2;
  final Color? backgroundColor;

  const ConvexButton2({
    super.key,
    this.size,
    this.sigma,
    required this.child,
    this.child2,
    this.thickness,
    this.backgroundColor,
    this.top,
  });

  factory ConvexButton2.fab({
    Key? key,
    double? size,
    double? thickness,
    double? top,
    double? sigma,
    double iconSize = 32,
    double border = 2,
    Color color = Colors.redAccent,
    IconData icon = Icons.keyboard_voice,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    final button = Material(
      type: MaterialType.transparency,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Center(child: Icon(icon, color: color, size: iconSize)),
      ),
    );
    return ConvexButton2(
      key: key,
      size: size,
      thickness: thickness,
      top: top,
      backgroundColor: backgroundColor,
      sigma: sigma,
      child: button,
    );
  }

  factory ConvexButton2.fab2({
    Key? key,
    double? size,
    double? thickness,
    double? top,
    double? sigma,
    Widget? thicknessChild,
    Widget? child,
    double border = 2,
    Color color = Colors.redAccent,
    Color? backgroundColor,
  }) {
    return ConvexButton2(
      key: key,
      size: size,
      thickness: thickness,
      top: top,
      backgroundColor: backgroundColor,
      sigma: sigma,
      child2: thicknessChild,
      child: child ?? const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.karingTheme;
    final buttonSize = size ?? _DEFAULT_SIZE;
    final dockHeight = thickness ?? _DEFAULT_THICKNESS;
    final totalHeight = dockHeight + buttonSize * 0.28;
    final dockColor = backgroundColor ?? colors.panelBackground;

    return SizedBox(
      height: totalHeight,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: KaringSpacing.lg,
            right: KaringSpacing.lg,
            bottom: KaringSpacing.sm,
            height: dockHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: dockColor,
                borderRadius: BorderRadius.circular(KaringRadius.xl),
                border: Border.all(color: colors.subtleBorder),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withValues(alpha: 0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: KaringSpacing.lg,
                  end: buttonSize + KaringSpacing.xxl,
                ),
                child: child2 ?? const SizedBox.shrink(),
              ),
            ),
          ),
          PositionedDirectional(
            end: KaringSpacing.xxl,
            bottom: KaringSpacing.sm + (dockHeight - buttonSize) / 2,
            child: Semantics(
              container: true,
              child: AnimatedContainer(
                duration: KaringMotion.standard,
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: colors.panelBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withValues(alpha: 0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
