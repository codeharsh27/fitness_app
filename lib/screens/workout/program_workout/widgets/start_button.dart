import 'package:flutter/material.dart';

Widget buildProgramStartWorkoutButton(BuildContext context, String title, Color color) {
  return ElevatedButton(
    onPressed: () {
      // TODO: Navigate to actual workout session
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Starting $title workout...'),
          backgroundColor: color,
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 18),
      minimumSize: const Size(double.infinity, 60),
    ),
    child: const Text(
      'Start Today\'s Workout',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
