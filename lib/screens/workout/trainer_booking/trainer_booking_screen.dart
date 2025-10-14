import 'package:flutter/material.dart';
import 'package:fitness_app_saas/screens/workout/trainer_booking/widgets/widgets.dart';

class TrainerBookingScreen extends StatelessWidget {
  final String trainerName;
  final String trainerImage;
  final String trainerSpecialty;
  final String experience;
  final String rating;
  final Color color;

  const TrainerBookingScreen({
    super.key,
    required this.trainerName,
    required this.trainerImage,
    required this.trainerSpecialty,
    required this.experience,
    required this.rating,
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
              buildTrainerBookingHeader(context, trainerName, trainerSpecialty, rating, experience, trainerImage, color),

              // Trainer Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About Trainer
                      buildAboutSection(color),

                      const SizedBox(height: 20),

                      // Expertise & Experience
                      buildExpertiseSection(color, trainerSpecialty, experience),

                      const SizedBox(height: 20),

                      // Schedule & Availability
                      buildScheduleSection(color),

                      const SizedBox(height: 30),

                      // Book Trainer Button
                      buildBookButton(context, color, trainerName),
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
