import 'package:flutter/material.dart';

Widget buildAboutSection(Color color) {
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
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'A dedicated fitness professional with extensive experience in helping clients achieve their fitness goals. Specializes in personalized training programs that deliver real results through proven methodologies and expert guidance.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.9),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
