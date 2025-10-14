import 'package:flutter/material.dart';

Widget buildExerciseList(Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.fitness_center, color: color, size: 24),
          const SizedBox(width: 12),
          const Text(
            'Exercises',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _buildExerciseItem('Warm-up', '5 min cardio + dynamic stretches', '5 min'),
      _buildExerciseItem('Squats', '3 sets × 12-15 reps', 'Bodyweight'),
      _buildExerciseItem('Push-ups', '3 sets × 10-12 reps', 'Bodyweight'),
      _buildExerciseItem('Lunges', '3 sets × 10 reps each leg', 'Bodyweight'),
      _buildExerciseItem('Plank', '3 sets × 30-45 seconds', 'Core'),
      _buildExerciseItem('Burpees', '3 sets × 8-10 reps', 'Full body'),
      _buildExerciseItem('Cool-down', 'Stretching and breathing', '5 min'),
    ],
  );
}

Widget _buildExerciseItem(String name, String sets, String type) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade700, width: 1),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sets,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    ),
  );
}
