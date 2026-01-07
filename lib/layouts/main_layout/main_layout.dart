// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/layouts/achievement_layout/achievement_layout.dart';
import 'package:goals_app/layouts/main_layout/components/goal_item.dart';
import 'package:goals_app/layouts/main_layout/empty_main.dart';
import 'package:goals_app/layouts/main_layout/main_cubit/main_cubit.dart';
import 'package:goals_app/layouts/main_layout/main_cubit/main_state.dart';
import 'package:goals_app/utils/app_strings.dart';
import 'package:goals_app/utils/snackbar.dart';
import 'package:goals_app/utils/undo_delte.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              MainCubit()
                ..initDataBase()
                ..getDataFormDataBase(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {
          if (state is InsertDataSuccessState) {
            showCustomSnackBar(
              context: context,
              message: 'Goal added successfully',
              color: Colors.teal,
              icon: Icons.add_task,
            );
          }

          if (state is DeleteDataSuccessState) {
            showUndoSnackBar(
              context: context,
              message: 'Goal deleted',
              onUndo: () {
                MainCubit.get(context).undoDelete();
              },
            );
          }
        },

        builder: (context, state) {
          final goals = MainCubit.get(context).activeGoals;
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
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_events,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider.value(
                                value: MainCubit.get(context),
                                child: const AchievementsScreen(),
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child:
                    MainCubit.get(context).activeGoals.isEmpty
                        ? buildEmptyState()
                        : ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Dismissible(
                                key: ValueKey(
                                  MainCubit.get(context).goalList[index]['id'],
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  MainCubit.get(context).deleteData(
                                    MainCubit.get(
                                      context,
                                    ).goalList[index]['id'],
                                  );
                                },
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),

                                child: goalItem(
                                  goalName: goals[index]['name'],
                                  isCompleted: false,
                                  onChanged: () {
                                    MainCubit.get(context).toggleGoalStatus(
                                      id: goals[index]['id'],
                                      isCompleted: true,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: goals.length,
                        ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.teal, width: 2),
                ),
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
                          controller: MainCubit.get(context).goalController,
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
                              final text =
                                  MainCubit.get(
                                    context,
                                  ).goalController.text.trim();
                              if (text.isEmpty) {
                                showCustomSnackBar(
                                  context: context,
                                  message: 'Please enter a goal',
                                  color: Colors.red,
                                  icon: Icons.error,
                                );
                                return;
                              }
                              MainCubit.get(context).insertData(text);
                              MainCubit.get(context).getDataFormDataBase();
                              MainCubit.get(context).goalController.clear();
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
        },
      ),
    );
  }
}
