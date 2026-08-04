import 'package:flutter/material.dart';
import 'package:karing/app/modules/server_manager.dart';
import 'package:karing/app/modules/setting_manager.dart';
import 'package:karing/app/runtime/return_result.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';
import 'package:karing/i18n/strings.g.dart';
import 'package:karing/screens/dialog_utils.dart';
import 'package:karing/screens/theme_config.dart';
import 'package:karing/screens/themes.dart';
import 'package:tuple/tuple.dart';
import 'package:vpn_service/state.dart';

class CommonWidget {
  static const double kLatencyWidget = 68;

  static Widget createLatencyWidget(
    BuildContext context,
    Themes themes,
    double? height,
    bool loading,
    bool isTesting,
    String latency, {
    void Function()? onTapLatencyReload,
  }) {
    final semantic = context.karingTheme;
    final theme = Theme.of(context);
    const defaultHeight = 30.0;

    if (loading) {
      return SizedBox(
        width: kLatencyWidget,
        height: height ?? defaultHeight,
        child: Center(
          child: SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              color: isTesting ? semantic.success : null,
            ),
          ),
        ),
      );
    }
    if (latency.isEmpty) {
      return const SizedBox(width: kLatencyWidget);
    }

    final value = int.tryParse(latency);
    if (value == null) {
      return SizedBox(
        width: kLatencyWidget,
        height: height ?? defaultHeight,
        child: IconButton(
          tooltip: latency,
          visualDensity: VisualDensity.compact,
          onPressed: () async {
            if (onTapLatencyReload == null) {
              DialogUtils.showAlertDialog(context, latency);
              return;
            }
            final retry = await DialogUtils.showConfirmDialog(
              context,
              '$latency\n\n${Translations.of(context).meta.retry}',
              showCopy: true,
              withVersion: true,
            );
            if (retry == true) onTapLatencyReload();
          },
          icon: Icon(
            Icons.warning_amber_rounded,
            color: semantic.danger,
            size: 20,
          ),
        ),
      );
    }

    late final Color foreground;
    late final Color background;
    if (value < 300) {
      foreground = semantic.success;
      background = semantic.successContainer;
    } else if (value < 800) {
      foreground = semantic.warning;
      background = semantic.warningContainer;
    } else {
      foreground = semantic.danger;
      background = semantic.dangerContainer;
    }

    return SizedBox(
      width: kLatencyWidget,
      height: height ?? defaultHeight,
      child: InkWell(
        borderRadius: BorderRadius.circular(KaringRadius.pill),
        onTap: onTapLatencyReload,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(KaringRadius.pill),
          ),
          child: Text(
            '$latency ms',
            maxLines: 1,
            style: theme.textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  static Row createGroupTraffic(
    BuildContext context,
    String groupId,
    bool showISPIfExpiring,
    SubscriptionTraffic? traffic,
    double offset,
    MainAxisAlignment? mainAxisAlignment,
    double windowWidth,
    void Function(String) reloadStart,
    void Function(String, ReturnResult<SubscriptionTraffic> value) reloadFinish,
  ) {
    if (traffic == null) return const Row();

    final theme = Theme.of(context);
    final semantic = context.karingTheme;
    final settings = SettingManager.getConfig();
    final Tuple2<bool, String> expiration = traffic.getExpireTime(
      settings.languageTag,
    );
    final expiring = expiration.item1;
    final expireTime = expiration.item2;
    final fontSize = windowWidth >= 335
        ? ThemeConfig.kFontSizeListSubItem
        : 12.0;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        SizedBox(width: offset),
        Expanded(
          child: Wrap(
            spacing: KaringSpacing.md,
            runSpacing: KaringSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '↑ ${traffic.upload}  ↓ ${traffic.download}  / ${traffic.total}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: fontSize,
                  color: traffic.overQuota ? semantic.danger : null,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(KaringRadius.sm),
                onTap: () {
                  ServerManager.reloadTraffic(groupId).then((value) {
                    reloadFinish(groupId, value);
                  });
                  reloadStart(groupId);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KaringSpacing.xs,
                    vertical: KaringSpacing.xxs,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: expiring ? semantic.danger : semantic.warning,
                      ),
                      const SizedBox(width: KaringSpacing.xs),
                      Text(
                        expireTime,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize,
                          color: expiring ? semantic.danger : null,
                        ),
                      ),
                      const SizedBox(width: KaringSpacing.xs),
                      if (ServerManager.isReloadingTraffic(groupId))
                        const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(),
                        )
                      else
                        const Icon(Icons.refresh_rounded, size: 17),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget createNeedPermission(
    BuildContext context,
    String text,
    Function() onPermission,
    Function() onRefresh,
  ) {
    final tcontext = Translations.of(context);
    final semantic = context.karingTheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.all(KaringSpacing.xxl),
          decoration: BoxDecoration(
            color: semantic.panelBackground,
            borderRadius: BorderRadius.circular(KaringRadius.lg),
            border: Border.all(color: semantic.subtleBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.admin_panel_settings_outlined,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: KaringSpacing.lg),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: KaringSpacing.xl),
              FilledButton.icon(
                onPressed: onPermission,
                icon: const Icon(Icons.lock_open_rounded),
                label: Text(text),
              ),
              const SizedBox(height: KaringSpacing.sm),
              TextButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(tcontext.meta.refresh),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
