import 'package:flutter/material.dart';

Widget buildBookButton(BuildContext context, Color color, String trainerName) {
  return ElevatedButton(
    onPressed: () {
      _showBookingDialog(context, trainerName);
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
      'Book Training Session',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

void _showBookingDialog(BuildContext context, String trainerName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          'Book Training Session',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Your booking request has been sent to $trainerName. You will receive a confirmation shortly.',
          style: TextStyle(color: Colors.white.withOpacity(0.9)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: Colors.orange)),
          ),
        ],
      );
    },
  );
}
