import 'package:flutter/material.dart';
Widget goalItem({
  required String goalName,
  required bool isCompleted,
  required VoidCallback onChanged,
}) {
  return Container(
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.teal,
      border: Border.all(color: Colors.teal, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const SizedBox(width: 12),
        Checkbox(
          value: isCompleted,
          onChanged: (_) => onChanged(),
          fillColor: MaterialStateProperty.all(Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            goalName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

