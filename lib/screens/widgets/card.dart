import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';
import 'package:karing/screens/dialog_utils.dart';

import 'constant.dart';
import 'enum.dart';
import 'fade_box.dart';

class Info {
  final String label;
  final IconData? iconData;
  final String tips;

  const Info({required this.label, this.iconData, this.tips = ""});
}

class InfoHeader extends StatelessWidget {
  final Info info;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;

  const InfoHeader({
    super.key,
    required this.info,
    this.padding,
    List<Widget>? actions,
  }) : actions = actions ?? const [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.karingTheme;

    return Padding(
      padding: padding ?? baseInfoEdgeInsets,
      child: Row(
        children: [
          if (info.iconData != null) ...[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.subtleSurface,
                borderRadius: BorderRadius.circular(KaringRadius.sm),
              ),
              child: Icon(
                info.iconData,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: KaringSpacing.md),
          ],
          Expanded(
            child: Tooltip(
              message: info.label,
              child: Text(
                info.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (info.tips.isNotEmpty) ...[
            const SizedBox(width: KaringSpacing.xs),
            IconButton(
              tooltip: info.tips,
              visualDensity: VisualDensity.compact,
              iconSize: 18,
              onPressed: () {
                DialogUtils.showAlertDialog(context, info.tips);
              },
              icon: const Icon(Icons.info_outline_rounded),
            ),
          ],
          if (actions.isNotEmpty) ...[
            const SizedBox(width: KaringSpacing.sm),
            Row(mainAxisSize: MainAxisSize.min, children: actions),
          ],
        ],
      ),
    );
  }
}

class CommonCard extends StatefulWidget {
  const CommonCard({
    super.key,
    bool? isSelected,
    this.type = CommonCardType.plain,
    this.onPressed,
    this.onLongPress,
    this.selectWidget,
    this.radius = KaringRadius.lg,
    required this.child,
    this.padding,
    this.enterAnimated = false,
    this.info,
    this.focusNode,
    this.alpha = 255,
  }) : isSelected = isSelected ?? false;

  final bool enterAnimated;
  final bool isSelected;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final Widget? selectWidget;
  final Widget child;
  final EdgeInsets? padding;
  final Info? info;
  final CommonCardType type;
  final double radius;
  final FocusNode? focusNode;
  final int alpha;

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.karingTheme;
    final interactive = widget.onPressed != null || widget.onLongPress != null;
    final highlighted = widget.isSelected || _hovered || _focused;

    Color background;
    if (widget.type == CommonCardType.filled) {
      background = widget.isSelected
          ? theme.colorScheme.primaryContainer
          : colors.subtleSurface;
    } else if (widget.isSelected) {
      background = theme.colorScheme.primaryContainer.withValues(alpha: 0.55);
    } else {
      final safeAlpha = widget.alpha.clamp(0, 255).toInt();
      background = colors.panelBackground.withAlpha(safeAlpha);
    }

    final borderColor = highlighted
        ? theme.colorScheme.primary.withValues(
            alpha: widget.isSelected ? 0.7 : 0.35,
          )
        : colors.subtleBorder;

    Widget content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.info == null
          ? widget.child
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfoHeader(
                  padding: baseInfoEdgeInsets.copyWith(bottom: 0),
                  info: widget.info!,
                ),
                Flexible(child: widget.child),
              ],
            ),
    );

    if (widget.selectWidget != null && widget.isSelected) {
      content = Stack(
        children: [content, Positioned.fill(child: widget.selectWidget!)],
      );
    }

    Widget card = AnimatedContainer(
      duration: KaringMotion.fast,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(widget.radius),
        border: Border.all(color: borderColor),
        boxShadow: highlighted && interactive
            ? [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(widget.radius),
        child: InkWell(
          focusNode: widget.focusNode,
          canRequestFocus: interactive,
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: (value) {
            if (_hovered != value) {
              setState(() => _hovered = value);
            }
          },
          onFocusChange: (value) {
            if (_focused != value) {
              setState(() => _focused = value);
            }
          },
          overlayColor: WidgetStatePropertyAll(
            theme.colorScheme.primary.withValues(alpha: 0.06),
          ),
          child: content,
        ),
      ),
    );

    if (widget.enterAnimated) {
      card = FadeScaleEnterBox(child: card);
    }
    return card;
  }
}

class SelectIcon extends StatelessWidget {
  const SelectIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        margin: const EdgeInsets.all(KaringSpacing.sm),
        padding: const EdgeInsets.all(KaringSpacing.xs),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 15,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class SettingsBlock extends StatelessWidget {
  final String title;
  final List<Widget> settings;

  const SettingsBlock({super.key, required this.title, required this.settings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.karingTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        KaringSpacing.lg,
        KaringSpacing.sm,
        KaringSpacing.lg,
        KaringSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              KaringSpacing.xs,
              KaringSpacing.md,
              KaringSpacing.xs,
              KaringSpacing.sm,
            ),
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: colors.panelBackground,
              borderRadius: BorderRadius.circular(KaringRadius.lg),
              border: Border.all(color: colors.subtleBorder),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(children: settings),
          ),
        ],
      ),
    );
  }
}
