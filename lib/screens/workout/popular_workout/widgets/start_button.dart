import 'package:flutter/material.dart';

Widget buildStartWorkoutButton(BuildContext context, String title, Color color) {
  return ElevatedButton(
    onPressed: () {
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
      'Start Workout',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}
