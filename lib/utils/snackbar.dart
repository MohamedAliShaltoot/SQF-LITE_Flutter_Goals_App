import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required Color color,
  required IconData icon,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      backgroundColor: color,
      elevation: 6,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}
