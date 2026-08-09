import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

abstract final class AccessibilityUtils {
  static void announce(BuildContext context, String message) {
    if (message.trim().isEmpty) {
      return;
    }
    SemanticsService.announce(message, Directionality.of(context));
  }
}
