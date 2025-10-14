import 'package:flutter/material.dart';

Widget buildExpertiseSection(Color color, String trainerSpecialty, String experience) {
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
            Icon(Icons.workspace_premium, color: color, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Expertise & Experience',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildExpertiseItem(
          'Certified Personal Trainer',
          'NASM, ACE Certified',
        ),
        _buildExpertiseItem('Specialization', trainerSpecialty),
        _buildExpertiseItem('Experience', experience),
        _buildExpertiseItem(
          'Training Style',
          'Progressive overload, Form-focused',
        ),
        _buildExpertiseItem('Client Success Rate', '95% goal achievement'),
      ],
    ),
  );
}

Widget _buildExpertiseItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
