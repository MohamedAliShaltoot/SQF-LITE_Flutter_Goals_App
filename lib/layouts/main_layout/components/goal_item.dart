import 'package:flutter/material.dart';

Widget goalItem({required String goalName}) {
  return Container(
    width: double.infinity,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.teal,
      border: Border.all(color: Colors.teal, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        goalName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
