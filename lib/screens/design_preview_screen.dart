import 'package:flutter/material.dart';
import 'package:karing/design_system/components/karing_components.dart';
import 'package:karing/design_system/theme/karing_theme_extension.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

class DesignPreviewScreen extends StatefulWidget {
  const DesignPreviewScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<DesignPreviewScreen> createState() => _DesignPreviewScreenState();
}

class _DesignPreviewScreenState extends State<DesignPreviewScreen> {
  int _selectedIndex = 0;
  bool _connected = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= KaringBreakpoints.medium;
        return Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Karing UI Preview'),
                Text(
                  'Phase 1 · Design system',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: widget.themeMode == ThemeMode.dark
                    ? '切换浅色模式'
                    : '切换深色模式',
                onPressed: () {
                  widget.onThemeModeChanged(
                    widget.themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
                icon: Icon(
                  widget.themeMode == ThemeMode.dark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              ),
              const SizedBox(width: KaringSpacing.sm),
            ],
          ),
          body: Row(
            children: [
              if (desktop)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _select,
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: KaringSpacing.lg),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(KaringRadius.md),
                      ),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: _NavigationMark(),
                      ),
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('首页概念'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.widgets_outlined),
                      selectedIcon: Icon(Icons.widgets_rounded),
                      label: Text('组件'),
                    ),
                  ],
                ),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    _HomePreview(
                      connected: _connected,
                      onToggle: () {
                        setState(() {
                          _connected = !_connected;
                        });
                      },
                    ),
                    const _ComponentPreview(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _select,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: '首页概念',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.widgets_outlined),
                      selectedIcon: Icon(Icons.widgets_rounded),
                      label: '组件',
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _select(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}

class _NavigationMark extends StatelessWidget {
  const _NavigationMark();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.shield_outlined,
      color: Theme.of(context).colorScheme.onPrimary,
    );
  }
}

class _HomePreview extends StatelessWidget {
  const _HomePreview({required this.connected, required this.onToggle});

  final bool connected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= KaringBreakpoints.expanded;
        final padding = constraints.maxWidth >= KaringBreakpoints.compact
            ? KaringInsets.pageExpanded
            : KaringInsets.pageCompact;

        final main = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KaringSectionTitle(
              title: '连接中心',
              description: '状态、当前节点和主操作集中呈现。',
            ),
            const SizedBox(height: KaringSpacing.lg),
            _ConnectionCard(connected: connected, onToggle: onToggle),
            const SizedBox(height: KaringSpacing.xxl),
            const KaringSectionTitle(
              title: '实时状态',
              description: '只保留需要快速扫读的数据。',
            ),
            const SizedBox(height: KaringSpacing.lg),
            const _MetricsCard(),
            const SizedBox(height: KaringSpacing.xxl),
            const KaringSectionTitle(
              title: '快捷功能',
              description: '高频入口保持明显，低频功能后续收纳。',
            ),
            const SizedBox(height: KaringSpacing.lg),
            const _QuickActions(),
          ],
        );

        final side = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KaringSectionTitle(title: '网络状态'),
            const SizedBox(height: KaringSpacing.lg),
            _NetworkStatus(connected: connected),
            const SizedBox(height: KaringSpacing.lg),
            const KaringQuickActionTile(
              label: '当前配置',
              description: '主订阅 · 剩余 82.4 GB',
              icon: Icons.cloud_download_outlined,
            ),
          ],
        );

        return SingleChildScrollView(
          padding: padding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: main),
                        const SizedBox(width: KaringSpacing.xxl),
                        SizedBox(width: 340, child: side),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        main,
                        const SizedBox(height: KaringSpacing.xxl),
                        side,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard({required this.connected, required this.onToggle});

  final bool connected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semantic = context.karingTheme;
    final statusColor = connected
        ? semantic.success
        : theme.colorScheme.primary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontal = constraints.maxWidth >= 640;
        final contentGap = horizontal ? KaringSpacing.xl : KaringSpacing.lg;
        final powerSize = horizontal ? 112.0 : 88.0;
        final powerIconSize = horizontal ? 48.0 : 40.0;

        return KaringSurfaceCard(
          emphasized: connected,
          padding: EdgeInsets.all(
            horizontal ? KaringSpacing.xxl : KaringSpacing.lg,
          ),
          child: Builder(
            builder: (context) {
              final details = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KaringStatusBadge(
                    label: connected ? '已连接' : '未连接',
                    tone: connected
                        ? KaringStatusTone.success
                        : KaringStatusTone.neutral,
                    icon: connected
                        ? Icons.check_circle_outline_rounded
                        : Icons.radio_button_unchecked_rounded,
                  ),
                  SizedBox(height: contentGap),
                  Text(
                    connected ? '日本 · Tokyo 01' : '选择一个节点开始连接',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: KaringSpacing.sm),
                  Text(
                    connected ? 'Trojan · 自动分流 · 42 ms' : '当前不会接管系统网络流量',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: contentGap),
                  Wrap(
                    spacing: KaringSpacing.sm,
                    runSpacing: KaringSpacing.sm,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.swap_horiz_rounded),
                        label: const Text('切换节点'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.tune_rounded),
                        label: const Text('分流模式'),
                      ),
                    ],
                  ),
                ],
              );

              final power = Semantics(
                button: true,
                toggled: connected,
                label: connected ? '断开连接' : '开始连接',
                child: InkWell(
                  onTap: onToggle,
                  customBorder: const CircleBorder(),
                  child: AnimatedContainer(
                    duration: KaringMotion.standard,
                    width: powerSize,
                    height: powerSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor.withValues(alpha: 0.12),
                      border: Border.all(color: statusColor, width: 2),
                    ),
                    child: Icon(
                      Icons.power_settings_new_rounded,
                      size: powerIconSize,
                      color: statusColor,
                    ),
                  ),
                ),
              );

              if (horizontal) {
                return Row(
                  children: [
                    Expanded(child: details),
                    const SizedBox(width: KaringSpacing.xxl),
                    power,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  details,
                  const SizedBox(height: KaringSpacing.lg),
                  Align(alignment: Alignment.center, child: power),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _MetricsCard extends StatelessWidget {
  const _MetricsCard();

  @override
  Widget build(BuildContext context) {
    final semantic = context.karingTheme;
    return KaringSurfaceCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 720
              ? 3
              : constraints.maxWidth >= 300
              ? 2
              : 1;
          final spacing = columns == 3 ? KaringSpacing.xxl : KaringSpacing.md;
          final width =
              (constraints.maxWidth - spacing * (columns - 1)) / columns;
          return Wrap(
            spacing: spacing,
            runSpacing: KaringSpacing.lg,
            children: [
              SizedBox(
                width: width,
                child: KaringMetric(
                  label: '上传',
                  value: '1.2 GB',
                  icon: Icons.arrow_upward_rounded,
                  iconColor: semantic.upload,
                ),
              ),
              SizedBox(
                width: width,
                child: KaringMetric(
                  label: '下载',
                  value: '4.8 GB',
                  icon: Icons.arrow_downward_rounded,
                  iconColor: semantic.download,
                ),
              ),
              SizedBox(
                width: width,
                child: const KaringMetric(
                  label: '当前速度',
                  value: '12.4 MB/s',
                  icon: Icons.speed_rounded,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 820 ? 2 : 1;
        final width =
            (constraints.maxWidth - KaringSpacing.md * (columns - 1)) / columns;
        const actions = [
          ('配置文件', '管理订阅与本地配置', Icons.folder_copy_outlined),
          ('分流规则', '选择模式与策略组', Icons.route_outlined),
          ('DNS', '解析策略与 Fake-IP', Icons.dns_outlined),
          ('应用代理', '控制应用是否经过代理', Icons.apps_outlined),
        ];

        return Wrap(
          spacing: KaringSpacing.md,
          runSpacing: KaringSpacing.md,
          children: [
            for (final action in actions)
              SizedBox(
                width: width,
                child: KaringQuickActionTile(
                  label: action.$1,
                  description: action.$2,
                  icon: action.$3,
                  onTap: () {},
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NetworkStatus extends StatelessWidget {
  const _NetworkStatus({required this.connected});

  final bool connected;

  @override
  Widget build(BuildContext context) {
    return KaringSurfaceCard(
      child: Column(
        children: [
          _InfoRow(label: '出口 IP', value: connected ? '103.125.***.***' : '—'),
          const Divider(height: KaringSpacing.xxl),
          _InfoRow(label: '活动连接', value: connected ? '18' : '0'),
          const Divider(height: KaringSpacing.xxl),
          _InfoRow(label: '运行时间', value: connected ? '01:42:18' : '—'),
          const Divider(height: KaringSpacing.xxl),
          const _InfoRow(label: '模式', value: '规则'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ComponentPreview extends StatelessWidget {
  const _ComponentPreview();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth >= KaringBreakpoints.compact
            ? KaringInsets.pageExpanded
            : KaringInsets.pageCompact;
        return SingleChildScrollView(
          padding: padding,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KaringSectionTitle(
                    title: '组件基线',
                    description: '验证视觉语言、浅深色主题与跨尺寸适配。',
                  ),
                  const SizedBox(height: KaringSpacing.xxl),
                  KaringSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '状态徽标',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: KaringSpacing.md),
                        const Wrap(
                          spacing: KaringSpacing.sm,
                          runSpacing: KaringSpacing.sm,
                          children: [
                            KaringStatusBadge(label: '默认'),
                            KaringStatusBadge(
                              label: '信息',
                              tone: KaringStatusTone.info,
                            ),
                            KaringStatusBadge(
                              label: '已连接',
                              tone: KaringStatusTone.success,
                            ),
                            KaringStatusBadge(
                              label: '需要注意',
                              tone: KaringStatusTone.warning,
                            ),
                            KaringStatusBadge(
                              label: '连接失败',
                              tone: KaringStatusTone.danger,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: KaringSpacing.lg),
                  KaringSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '按钮与表单',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: KaringSpacing.md),
                        Wrap(
                          spacing: KaringSpacing.sm,
                          runSpacing: KaringSpacing.sm,
                          children: [
                            FilledButton(
                              onPressed: () {},
                              child: const Text('主要操作'),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text('次要操作'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('文字操作'),
                            ),
                          ],
                        ),
                        const SizedBox(height: KaringSpacing.lg),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: '订阅链接',
                            hintText: 'https://example.com/subscription',
                            prefixIcon: Icon(Icons.link_rounded),
                          ),
                        ),
                        const SizedBox(height: KaringSpacing.md),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('启用 TUN 模式'),
                          subtitle: const Text('接管设备全部网络流量'),
                          value: true,
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: KaringSpacing.lg),
                  const KaringQuickActionTile(
                    label: '设置列表项',
                    description: '统一图标、标题、说明和跳转提示的对齐方式',
                    icon: Icons.tune_rounded,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
