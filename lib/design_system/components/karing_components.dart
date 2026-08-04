import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

enum KaringStatusTone { neutral, info, success, warning, danger }

class KaringStatusBadge extends StatelessWidget {
  const KaringStatusBadge({
    super.key,
    required this.label,
    this.tone = KaringStatusTone.neutral,
    this.icon,
  });

  final String label;
  final KaringStatusTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.$2,
        borderRadius: BorderRadius.circular(KaringRadius.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KaringSpacing.md,
          vertical: KaringSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: colors.$1),
              const SizedBox(width: KaringSpacing.xs),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colors.$1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  (Color, Color) _colors(BuildContext context) {
    final theme = Theme.of(context);
    final karing = context.karingTheme;
    return switch (tone) {
      KaringStatusTone.info => (
        theme.colorScheme.primary,
        theme.colorScheme.primaryContainer,
      ),
      KaringStatusTone.success => (karing.success, karing.successContainer),
      KaringStatusTone.warning => (karing.warning, karing.warningContainer),
      KaringStatusTone.danger => (karing.danger, karing.dangerContainer),
      KaringStatusTone.neutral => (
        theme.colorScheme.onSurfaceVariant,
        karing.subtleSurface,
      ),
    };
  }
}

class KaringSurfaceCard extends StatelessWidget {
  const KaringSurfaceCard({
    super.key,
    required this.child,
    this.padding = KaringInsets.card,
    this.onTap,
    this.emphasized = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final karing = context.karingTheme;
    final decoration = BoxDecoration(
      color: emphasized
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.38)
          : karing.panelBackground,
      border: Border.all(
        color: emphasized ? theme.colorScheme.primary : karing.subtleBorder,
      ),
      borderRadius: BorderRadius.circular(KaringRadius.lg),
    );

    final content = AnimatedContainer(
      duration: KaringMotion.standard,
      curve: Curves.easeOutCubic,
      decoration: decoration,
      padding: padding,
      child: child,
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(KaringRadius.lg),
        onTap: onTap,
        child: content,
      ),
    );
  }
}

class KaringSectionTitle extends StatelessWidget {
  const KaringSectionTitle({
    super.key,
    required this.title,
    this.description,
    this.trailing,
  });

  final String title;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (description != null) ...[
                const SizedBox(height: KaringSpacing.xs),
                Text(
                  description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class KaringMetric extends StatelessWidget {
  const KaringMetric({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? Theme.of(context).colorScheme.primary;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(KaringRadius.md),
          ),
          child: Padding(
            padding: const EdgeInsets.all(KaringSpacing.sm),
            child: Icon(icon, size: 20, color: color),
          ),
        ),
        const SizedBox(width: KaringSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: KaringSpacing.xxs),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class KaringQuickActionTile extends StatelessWidget {
  const KaringQuickActionTile({
    super.key,
    required this.label,
    required this.icon,
    this.description,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return KaringSurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(KaringSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: KaringSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: KaringSpacing.xxs),
                  Text(
                    description!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 20),
        ],
      ),
    );
  }
}
