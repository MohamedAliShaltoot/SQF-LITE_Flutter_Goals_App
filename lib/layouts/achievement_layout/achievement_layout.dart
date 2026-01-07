import 'package:flutter/material.dart';
import 'package:goals_app/layouts/main_layout/components/goal_item.dart';
import 'package:goals_app/layouts/main_layout/main_cubit/main_cubit.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedGoals = MainCubit.get(context).completedGoals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements 🏆'),
        backgroundColor: Colors.teal,
      ),
      body:
          completedGoals.isEmpty
              ? _emptyAchievements()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
              itemCount: completedGoals.length,
                itemBuilder: (context, index) {
                  final goal = completedGoals[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: goalItem(
                      goalName: goal['name'],
                      isCompleted: true,
                      onChanged: () {
                        MainCubit.get(
                          context,
                        ).toggleGoalStatus(id: goal['id'], isCompleted: false);
                      },
                    ),
                  );
                },
              ),
    );
  }
}
Widget _emptyAchievements() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey),
        SizedBox(height: 16),
        Text(
          'No achievements yet',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          'Complete a goal to see it here 🎯',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
