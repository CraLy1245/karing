// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:karing/app/utils/accessibility_utils.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';
import 'package:karing/i18n/strings.g.dart';
import 'package:karing/screens/dialog_utils.dart';
import 'package:karing/screens/group_item_options.dart';
import 'package:karing/screens/widgets/sheet.dart';
import 'package:karing/screens/widgets/text_field.dart';

class _TipsButton extends StatelessWidget {
  const _TipsButton(this.text);

  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null || text!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: KaringSpacing.sm),
      child: IconButton(
        tooltip: text,
        visualDensity: VisualDensity.compact,
        iconSize: 18,
        onPressed: () => DialogUtils.showAlertDialog(context, text!),
        icon: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}

class _RedDot extends StatelessWidget {
  const _RedDot({required this.visible, this.color});

  final bool visible;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: KaringSpacing.sm),
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: color ?? context.karingTheme.danger,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.child, this.onTap, this.onLongPress});

  final Widget child;
  final Future<void> Function()? onTap;
  final Future<void> Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KaringSpacing.lg),
          child: child,
        ),
      ),
    );
  }
}

Widget _label(BuildContext context, String text) {
  return Text(
    text,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
  );
}

Widget _value(
  BuildContext context,
  String text, {
  TextStyle? style,
  Color? color,
  int maxLines = 2,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.end,
    style:
        style ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
        ),
  );
}

class GroupItemText extends StatelessWidget {
  const GroupItemText({super.key, required this.options});

  final GroupItemTextOptions options;

  @override
  Widget build(BuildContext context) {
    return _SettingRow(
      onTap: options.onPush,
      onLongPress: options.onLongPress,
      child: Row(
        children: [
          if (options.child != null) ...[
            options.child!,
            const SizedBox(width: KaringSpacing.sm),
          ],
          _TipsButton(options.tips),
          Expanded(
            flex: ((1 - options.textWidthPercent) * 10).round(),
            child: _label(context, options.name),
          ),
          const SizedBox(width: KaringSpacing.md),
          Expanded(
            flex: (options.textWidthPercent * 10).round(),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: _value(
                context,
                options.text ?? "",
                style: options.textStyle,
                color: options.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupItemTextField extends StatelessWidget {
  const GroupItemTextField({super.key, required this.options});

  final GroupItemTextFieldOptions options;

  @override
  Widget build(BuildContext context) {
    final controller = options.controller ?? TextEditingController();
    controller.value = controller.value.copyWith(text: options.text);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KaringSpacing.lg),
      child: Row(
        children: [
          _TipsButton(options.tips),
          Expanded(
            flex: ((1 - options.textWidthPercent) * 10).round(),
            child: _label(context, options.name),
          ),
          const SizedBox(width: KaringSpacing.md),
          Expanded(
            flex: (options.textWidthPercent * 10).round(),
            child: TextFieldEx(
              style: options.textStyle,
              readOnly: options.readOnly,
              controller: controller,
              textInputAction: options.textInputAction,
              obscureText: options.obscureText,
              decoration: InputDecoration(
                hintText: options.hint,
                errorText: options.errorText,
                filled: false,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: KaringSpacing.sm,
                  vertical: KaringSpacing.sm,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              textAlign: TextAlign.end,
              keyboardType: options.keyboardType,
              inputFormatters: options.inputFormatters,
              focusNode: options.focusNode,
              autocorrect: false,
              enableSuggestions: true,
              autofocus: options.autoFocus,
              onChanged: options.onChanged,
              enabled: options.enabled,
              onSubmitted: options.onSubmitted,
              title: options.name,
              autocompleteCandidates: options.autocompleteCandidates,
            ),
          ),
        ],
      ),
    );
  }
}

class GroupItemSwitch extends StatelessWidget {
  const GroupItemSwitch({super.key, required this.options});

  final GroupItemSwitchOptions options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KaringSpacing.lg),
      child: Row(
        children: [
          _TipsButton(options.tips),
          _RedDot(visible: options.reddot == true),
          Expanded(child: _label(context, options.name)),
          Switch.adaptive(
            value: options.switchValue ?? false,
            onChanged: options.onSwitch == null
                ? null
                : (value) {
                    final statusText = value
                        ? Translations.of(context).meta.enable
                        : Translations.of(context).meta.disable;
                    AccessibilityUtils.announce(
                      context,
                      '${options.name} $statusText',
                    );
                    options.onSwitch!(value);
                  },
          ),
        ],
      ),
    );
  }
}

class GroupItemPush extends StatelessWidget {
  const GroupItemPush({super.key, required this.options});

  final GroupItemPushOptions options;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SettingRow(
      onTap: options.onPush,
      onLongPress: options.onLongPress,
      child: Row(
        children: [
          _TipsButton(options.tips),
          _RedDot(visible: options.reddot == true, color: options.reddotColor),
          if (options.icon != null) ...[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.karingTheme.subtleSurface,
                borderRadius: BorderRadius.circular(KaringRadius.sm),
              ),
              child: Icon(
                options.icon,
                size: 18,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: KaringSpacing.md),
          ],
          Expanded(
            flex: ((1 - options.textWidthPercent) * 10).round(),
            child: _label(context, options.name),
          ),
          if ((options.text ?? '').isNotEmpty) ...[
            const SizedBox(width: KaringSpacing.md),
            Expanded(
              flex: (options.textWidthPercent * 10).round(),
              child: _value(
                context,
                options.text ?? "",
                style: options.textStyle,
                color: options.textColor,
              ),
            ),
          ],
          const SizedBox(width: KaringSpacing.sm),
          Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class GroupItemTimerIntervalPicker extends StatelessWidget {
  const GroupItemTimerIntervalPicker({super.key, required this.options});

  final GroupItemTimerIntervalPickerOptions options;

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    return _SettingRow(
      onTap: options.onPicker == null
          ? null
          : () async {
              final result = await DialogUtils.showTimeIntervalPickerDialog(
                context,
                options.duration,
                showDays: options.showDays,
                showHours: options.showHours,
                showMinutes: options.showMinutes,
                showSeconds: options.showSeconds,
                showMilliSeconds: options.showMilliSeconds,
                showDisable: options.showDisable,
              );
              if (result != null) {
                options.duration = result.data;
              }
              options.onPicker!(result == null, options.duration);
            },
      child: Row(
        children: [
          _TipsButton(options.tips),
          _RedDot(visible: options.reddot == true),
          Expanded(child: _label(context, options.name)),
          _value(context, _durationToString(options, tcontext.meta.disable)),
          const SizedBox(width: KaringSpacing.sm),
          Icon(
            Icons.schedule_rounded,
            size: 19,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  String _durationToString(
    GroupItemTimerIntervalPickerOptions options,
    String disable,
  ) {
    final duration = options.duration;
    if (duration == null) {
      return disable;
    }
    if (duration.inDays > 0) return '${duration.inDays} d';
    if (duration.inHours > 0) return '${duration.inHours} h';
    if (duration.inMinutes > 0) return '${duration.inMinutes} m';
    if (duration.inSeconds > 0) return '${duration.inSeconds} s';
    if (duration.inMilliseconds > 0) return '${duration.inMilliseconds} ms';
    if (options.showDays) return '0 d';
    if (options.showHours) return '0 h';
    if (options.showMinutes) return '0 m';
    if (options.showSeconds) return '0 s';
    if (options.showMilliSeconds) return '0 ms';
    return '0';
  }
}

// ignore: must_be_immutable
class GroupItemDateTimeDurationPicker extends StatelessWidget {
  GroupItemDateTimeDurationPicker({super.key, required this.options}) {
    final initialStart = options.start;
    var initialEnd = options.end;
    if (initialStart != null &&
        initialEnd != null &&
        initialEnd.isBefore(initialStart)) {
      initialEnd = initialStart;
    }
    start = ValueNotifier(initialStart ?? DateTime.now());
    end = ValueNotifier(initialEnd ?? DateTime.now());
  }

  final GroupItemDateTimePeriodPickerOptions options;
  final BoardMultiDateTimeController controller =
      BoardMultiDateTimeController();
  late ValueNotifier<DateTime> start;
  late ValueNotifier<DateTime> end;

  @override
  Widget build(BuildContext context) {
    return _SettingRow(
      onTap: options.onPicker == null
          ? null
          : () async {
              final result = await showBoardDateTimeMultiPicker(
                context: context,
                controller: controller,
                pickerType: options.pickerType,
                minimumDate: options.minimumDate,
                maximumDate: options.maximumDate,
                startDate: start.value,
                endDate: end.value,
                options: BoardDateTimeOptions(
                  activeColor: Theme.of(context).colorScheme.primary,
                  languages: BoardPickerLanguages.en(),
                  startDayOfWeek: DateTime.sunday,
                  pickerFormat: PickerFormat.ymd,
                  useAmpm: false,
                ),
                customCloseButtonBuilder: null,
              );
              if (result != null) {
                start.value = result.start;
                end.value = result.end;
                options.onPicker?.call(result.start, result.end);
              }
            },
      child: Row(
        children: [
          _TipsButton(options.tips),
          _RedDot(visible: options.reddot == true),
          Expanded(flex: 4, child: _label(context, options.name)),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ValueListenableBuilder<DateTime>(
                  valueListenable: start,
                  builder: (context, data, _) => _value(
                    context,
                    BoardDateFormat(options.pickerType.format).format(data),
                    maxLines: 1,
                  ),
                ),
                ValueListenableBuilder<DateTime>(
                  valueListenable: end,
                  builder: (context, data, _) => _value(
                    context,
                    '– ${BoardDateFormat(options.pickerType.format).format(data)}',
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: KaringSpacing.sm),
          Icon(
            options.pickerType.icon,
            size: 19,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

extension DateTimePickerTypeExtension on DateTimePickerType {
  String get title {
    switch (this) {
      case DateTimePickerType.date:
        return 'Date';
      case DateTimePickerType.datetime:
        return 'DateTime';
      case DateTimePickerType.time:
        return 'Time';
    }
  }

  IconData get icon {
    switch (this) {
      case DateTimePickerType.date:
      case DateTimePickerType.datetime:
        return Icons.date_range_rounded;
      case DateTimePickerType.time:
        return Icons.schedule_rounded;
    }
  }

  Color get color {
    switch (this) {
      case DateTimePickerType.date:
        return Colors.blue;
      case DateTimePickerType.datetime:
        return Colors.orange;
      case DateTimePickerType.time:
        return Colors.pink;
    }
  }

  String get format {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return 'HH:mm';
    }
  }

  String formatter({bool withSecond = false}) {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return withSecond ? 'HH:mm:ss' : 'HH:mm';
    }
  }
}

class GroupItemStringPicker extends StatelessWidget {
  const GroupItemStringPicker({super.key, required this.options});

  final GroupItemStringPickerOptions options;

  @override
  Widget build(BuildContext context) {
    var selectedText = options.selected ?? "";
    final widgets = <Widget>[];

    if (options.tupleStrings != null) {
      for (final item in options.tupleStrings!) {
        final selected = options.selected == item.item1;
        if (selected) selectedText = item.item2;
        widgets.add(
          ListTile(
            title: Text(
              item.item2,
              style: TextStyle(fontFamily: Platform.isWindows ? 'Emoji' : null),
            ),
            trailing: selected ? const Icon(Icons.check_rounded) : null,
            selected: selected,
            onTap: () async {
              Navigator.pop(context);
              options.selected = item.item1;
              options.onPicker?.call(options.selected);
            },
          ),
        );
      }
    } else if (options.strings != null) {
      for (final item in options.strings!) {
        final selected = options.selected == item;
        widgets.add(
          ListTile(
            title: Text(
              item ?? "",
              style: TextStyle(fontFamily: Platform.isWindows ? 'Emoji' : null),
            ),
            trailing: selected ? const Icon(Icons.check_rounded) : null,
            selected: selected,
            onTap: () async {
              Navigator.pop(context);
              options.selected = item;
              options.onPicker?.call(options.selected);
            },
          ),
        );
      }
    }

    return _SettingRow(
      onTap: options.onPicker == null
          ? null
          : () async {
              await showSheetWidgets(context: context, widgets: widgets);
            },
      child: Row(
        children: [
          _TipsButton(options.tips),
          _RedDot(visible: options.reddot == true),
          Expanded(
            flex: ((1 - options.textWidthPercent) * 10).round(),
            child: _label(context, options.name),
          ),
          const SizedBox(width: KaringSpacing.md),
          Expanded(
            flex: (options.textWidthPercent * 10).round(),
            child: _value(
              context,
              selectedText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontFamily: Platform.isWindows ? 'Emoji' : null,
              ),
            ),
          ),
          const SizedBox(width: KaringSpacing.sm),
          Icon(
            Icons.unfold_more_rounded,
            size: 19,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
