import 'package:flutter/material.dart';

Widget buildEmptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.flag_outlined, size: 80, color: Colors.grey),
        SizedBox(height: 16),
        Text(
          'No goals yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Start by adding your first goal 🎯',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}
