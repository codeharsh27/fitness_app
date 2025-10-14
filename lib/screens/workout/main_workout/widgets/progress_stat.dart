import 'package:flutter/material.dart';

Widget buildProgressStat(String label, String value, String total) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '$label / $total',
        style: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
    ],
  );
}
