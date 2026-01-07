import 'package:flutter/material.dart';

void showUndoSnackBar({
  required BuildContext context,
  required String message,
  required VoidCallback onUndo,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(message),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Colors.white,
        onPressed: onUndo,
      ),
    ),
  );
}
