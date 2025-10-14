import 'package:flutter/material.dart';

Widget buildProgressSection(Color color) {
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
            Icon(Icons.analytics, color: color, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Progress Tracking',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildProgressItem('Week 1', 'Foundation Building', 0.1, color),
        _buildProgressItem('Week 2-4', 'Strength Development', 0.3, color),
        _buildProgressItem('Week 5-8', 'Muscle Building', 0.6, color),
        _buildProgressItem('Week 9-12', 'Peak Performance', 1.0, color),
      ],
    ),
  );
}

Widget _buildProgressItem(String period, String phase, double progress, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              period,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(fontSize: 12, color: color),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          phase,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey.shade700,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    ),
  );
}
