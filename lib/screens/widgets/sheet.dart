import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

bool _useDialogPresentation(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= KaringBreakpoints.compact;
}

Future<T?> showSheet<T>({
  required BuildContext context,
  required Widget body,
  bool isScrollControlled = true,
}) {
  if (_useDialogPresentation(context)) {
    return showDialog<T>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(KaringSpacing.xxl),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560,
              maxHeight: MediaQuery.sizeOf(dialogContext).height - 64,
            ),
            child: SafeArea(child: body),
          ),
        );
      },
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(child: body),
  );
}

typedef SheetBuilder = Widget Function(BuildContext context);

Future<T?> showSheetWithBuilder<T>({
  required BuildContext context,
  required SheetBuilder builder,
}) {
  if (_useDialogPresentation(context)) {
    return showDialog<T>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(KaringSpacing.xxl),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560,
              maxHeight: MediaQuery.sizeOf(dialogContext).height - 64,
            ),
            child: SafeArea(child: builder(dialogContext)),
          ),
        );
      },
    );
  }

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: false,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetContext) => SafeArea(child: builder(sheetContext)),
  );
}

class AdaptiveSheetScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget> actions;

  const AdaptiveSheetScaffold({
    super.key,
    required this.body,
    required this.title,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.karingTheme;
    final desktop = _useDialogPresentation(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.panelBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(desktop ? KaringRadius.lg : KaringRadius.xl),
          bottom: Radius.circular(desktop ? KaringRadius.lg : 0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!desktop)
            Padding(
              padding: const EdgeInsets.only(top: KaringSpacing.md),
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.35,
                  ),
                  borderRadius: BorderRadius.circular(KaringRadius.pill),
                ),
              ),
            ),
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(title),
            actions: actions,
          ),
          Divider(color: colors.subtleBorder),
          Flexible(child: body),
        ],
      ),
    );
  }
}

Future<void> showSheetWidgets({
  required BuildContext context,
  required List<dynamic> widgets,
  bool isScrollControlled = true,
}) {
  final estimatedHeight = (widgets.length * 56.0 + 32).clamp(160.0, 460.0);
  return showSheet<void>(
    context: context,
    isScrollControlled: isScrollControlled,
    body: SizedBox(
      height: estimatedHeight,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          KaringSpacing.md,
          KaringSpacing.xs,
          KaringSpacing.md,
          KaringSpacing.lg,
        ),
        itemBuilder: (itemContext, index) => widgets[index] as Widget,
        separatorBuilder: (itemContext, index) => const Divider(
          indent: KaringSpacing.lg,
          endIndent: KaringSpacing.lg,
        ),
        itemCount: widgets.length,
      ),
    ),
  );
}
