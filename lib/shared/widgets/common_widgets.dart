import 'package:flutter/material.dart';

// Common card decoration used across workout screens
BoxDecoration buildWorkoutCardDecoration({Color? backgroundColor, Color? borderColor}) {
  return BoxDecoration(
    color: backgroundColor ?? Colors.grey.shade800,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: borderColor ?? Colors.grey.shade700,
      width: 1,
    ),
  );
}

// Common gradient background used in headers
BoxDecoration buildHeaderGradientDecoration({Color? overlayColor}) {
  return BoxDecoration(
    color: overlayColor ?? Colors.grey.shade900.withOpacity(0.5),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),
  );
}

// Common section title with icon
Widget buildSectionTitle(String title, IconData icon, Color iconColor) {
  return Row(
    children: [
      Icon(icon, color: iconColor, size: 24),
      const SizedBox(width: 12),
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  );
}

// Common overview row used in multiple screens
Widget buildOverviewRow(String label, String value) {
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

// Common elevated button style used across screens
ElevatedButton buildWorkoutElevatedButton({
  required VoidCallback onPressed,
  required String text,
  Color? backgroundColor,
  Color? foregroundColor,
  double? fontSize,
  double? padding,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.orange,
      foregroundColor: foregroundColor ?? Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(vertical: padding ?? 18),
      minimumSize: const Size(double.infinity, 60),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
