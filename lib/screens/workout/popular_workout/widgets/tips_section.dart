import 'package:flutter/material.dart';

Widget buildTipsSection(Color color) {
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
            Icon(Icons.lightbulb_outline, color: color, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Pro Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTipItem('Focus on proper form before increasing intensity'),
        _buildTipItem('Rest 60-90 seconds between sets'),
        _buildTipItem('Stay hydrated throughout your workout'),
        _buildTipItem('Modify exercises if you feel any pain'),
      ],
    ),
  );
}

Widget _buildTipItem(String tip) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.orange, size: 16),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
