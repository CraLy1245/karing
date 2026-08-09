// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';
import 'package:karing/screens/group_item_options.dart';
import 'package:karing/screens/group_item_widgets.dart';
import 'package:karing/screens/theme_config.dart';

class GroupItem {
  GroupItem({
    this.name,
    this.itemHeight = ThemeConfig.kGroupItemHeight,
    required this.options,
  });
  final String? name;
  final double? itemHeight;
  final List<GroupItemOptions> options;
}

class GroupItemCreator {
  static List<Widget> createGroups(
    BuildContext context,
    List<GroupItem> groups, {
    bool scrollbar = false,
  }) {
    final creator = GroupItemCreator();
    return List<Widget>.generate(groups.length, (index) {
      final group = groups[index];
      return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: KaringLayout.settingsMaxWidth,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              KaringSpacing.lg,
              index == 0 ? KaringSpacing.sm : KaringSpacing.md,
              KaringSpacing.lg,
              KaringSpacing.sm,
            ),
            child: creator.createGroup(
              context,
              group,
              index == 0,
              scrollbar: scrollbar,
            ),
          ),
        ),
      );
    });
  }

  Widget _createGroupName(BuildContext context, GroupItem group) {
    if (group.name == null || group.name!.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        KaringSpacing.xs,
        KaringSpacing.sm,
        KaringSpacing.xs,
        KaringSpacing.sm,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          group.name!,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget createGroup(
    BuildContext context,
    GroupItem group,
    bool isFirstGroup, {
    bool scrollbar = false,
  }) {
    final colors = context.karingTheme;
    final widgets = <Widget>[];

    for (final option in group.options) {
      Widget? item;
      if (option.textOptions != null) {
        item = GroupItemText(options: option.textOptions!);
      } else if (option.textFormFieldOptions != null) {
        item = GroupItemTextField(options: option.textFormFieldOptions!);
      } else if (option.switchOptions != null) {
        item = GroupItemSwitch(options: option.switchOptions!);
      } else if (option.pushOptions != null) {
        item = GroupItemPush(options: option.pushOptions!);
      } else if (option.timerIntervalPickerOptions != null) {
        item = GroupItemTimerIntervalPicker(
          options: option.timerIntervalPickerOptions!,
        );
      } else if (option.dateTimePeriodPickerOptions != null) {
        item = GroupItemDateTimeDurationPicker(
          options: option.dateTimePeriodPickerOptions!,
        );
      } else if (option.stringPickerOptions != null) {
        item = GroupItemStringPicker(options: option.stringPickerOptions!);
      }
      if (item != null) {
        widgets.add(SizedBox(height: group.itemHeight, child: item));
      }
    }

    final separated = <Widget>[];
    for (var index = 0; index < widgets.length; index++) {
      separated.add(widgets[index]);
      if (index != widgets.length - 1) {
        separated.add(
          Divider(
            height: 1,
            thickness: 0.7,
            indent: KaringSpacing.lg,
            endIndent: KaringSpacing.lg,
            color: colors.subtleBorder,
          ),
        );
      }
    }

    final content = Container(
      decoration: BoxDecoration(
        color: colors.panelBackground,
        borderRadius: BorderRadius.circular(KaringRadius.lg),
        border: Border.all(color: colors.subtleBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(mainAxisSize: MainAxisSize.min, children: separated),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _createGroupName(context, group),
        scrollbar ? Scrollbar(child: content) : content,
      ],
    );
  }
}
