// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:karing/design_system/tokens/karing_tokens.dart';

class ListViewMultiPartsItem {
  int? bindNO;
  dynamic data;
  Widget Function(dynamic, int index, int? bindNO)? creator;
}

class ListViewMultiPartsBuilder {
  static Widget build(
    List<ListViewMultiPartsItem> parts, {
    ScrollController? controller,
    bool separator = true,
    EdgeInsetsGeometry? padding,
    double maxWidth = KaringLayout.contentMaxWidth,
  }) {
    Widget buildItem(BuildContext context, int index) {
      if (index >= parts.length) {
        return const SizedBox.shrink();
      }
      final current = parts[index];
      if (current.creator == null) {
        return const SizedBox.shrink();
      }
      return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: current.creator!(current.data, index, current.bindNO),
        ),
      );
    }

    final listPadding =
        padding ??
        const EdgeInsets.fromLTRB(
          KaringSpacing.lg,
          KaringSpacing.sm,
          KaringSpacing.lg,
          KaringSpacing.xxl,
        );

    final list = separator
        ? ListView.separated(
            controller: controller,
            padding: listPadding,
            itemCount: parts.length,
            itemBuilder: buildItem,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 0.7,
              indent: KaringSpacing.lg,
              endIndent: KaringSpacing.lg,
            ),
          )
        : ListView.builder(
            controller: controller,
            padding: listPadding,
            itemCount: parts.length,
            itemBuilder: buildItem,
          );

    return Scrollbar(
      controller: controller,
      thumbVisibility: controller != null,
      child: list,
    );
  }
}
