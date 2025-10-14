import 'package:flutter/material.dart';

Widget buildOverviewCard(String level, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade700, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline, color: color, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Workout Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildOverviewRow('Duration', '45-60 minutes'),
        _buildOverviewRow('Exercises', '8-12 exercises'),
        _buildOverviewRow('Target Muscles', 'Full body'),
        _buildOverviewRow('Equipment', 'Bodyweight + Dumbbells'),
        _buildOverviewRow('Level', level),
      ],
    ),
  );
}

Widget _buildOverviewRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
