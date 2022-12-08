// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

class CommonUtils {
  /// Show a [SnackBar] with the given [msg].
  static void showSnackBar(
    BuildContext ctx,
    String msg, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError
            ? Theme.of(ctx).colorScheme.error
            : Theme.of(ctx).colorScheme.secondary,
      ),
    );
  }
}
