import 'package:flutter/material.dart';
import 'package:fitness_app_saas/screens/workout/popular_workout/widgets/widgets.dart';

class PopularWorkoutDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;
  final String imageName;
  final Color color;

  const PopularWorkoutDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.level,
    required this.imageName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              buildPopularWorkoutHeader(context, title, subtitle, level, color),

              // Workout Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workout Overview Card
                      buildOverviewCard(level, color),

                      const SizedBox(height: 20),

                      // Exercise List
                      buildExerciseList(color),

                      const SizedBox(height: 20),

                      // Workout Tips
                      buildTipsSection(color),

                      const SizedBox(height: 30),

                      // Start Workout Button
                      buildStartWorkoutButton(context, title, color),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
