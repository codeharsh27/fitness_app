import 'package:flutter/material.dart';

Widget buildExerciseCategories(Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.fitness_center, color: color, size: 24),
          const SizedBox(width: 12),
          const Text(
            'Exercise Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 12,
        children: [
          _buildCategoryChip('Compound Lifts', Icons.arrow_upward, color),
          _buildCategoryChip('Isolation Work', Icons.radio_button_unchecked, color),
          _buildCategoryChip('Core Training', Icons.circle, color),
          _buildCategoryChip('Progressive Overload', Icons.trending_up, color),
          _buildCategoryChip('Recovery Focus', Icons.restore, color),
        ],
      ),
    ],
  );
}

Widget _buildCategoryChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade700, width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
