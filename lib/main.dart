import 'package:flutter/material.dart';
import 'package:goals_app/layouts/main_layout/main_layout.dart';
import 'package:goals_app/utils/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,

      home: MainLayout(),
    );
  }
}
