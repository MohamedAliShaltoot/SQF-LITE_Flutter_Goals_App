// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:goals_app/utils/app_strings.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.appTitle,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          shape: CircleBorder(side: BorderSide(color: Colors.teal, width: 2)),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(AppStrings.addNewGoal),
                  content: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                    
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      //label: Text(AppStrings.enterGoalHint),
                      labelText: AppStrings.enterGoalHint,
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Logic to add the goal goes here
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.add,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
