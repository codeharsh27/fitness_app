import 'package:flutter/material.dart';
import 'package:fitness_app_saas/screens/workout/program_workout/widgets/widgets.dart';

class ProgramWorkoutScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String imageName;

  const ProgramWorkoutScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.imageName,
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
              buildProgramWorkoutHeader(context, title, subtitle, icon, color),

              // Program Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Program Overview Card
                      buildProgramOverviewCard(color),

                      const SizedBox(height: 20),

                      // Weekly Schedule
                      buildWeeklySchedule(context, color),

                      const SizedBox(height: 20),

                      // Exercise Categories
                      buildExerciseCategories(color),

                      const SizedBox(height: 20),

                      // Progress Tracking
                      buildProgressSection(color),

                      const SizedBox(height: 30),

                      // Start Workout Button
                      buildProgramStartWorkoutButton(context, title, color),
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
