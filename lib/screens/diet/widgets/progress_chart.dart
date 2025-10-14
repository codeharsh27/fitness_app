import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  const ProgressChart({Key? key, required this.data, required this.labels})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 120),
      painter: LineChartPainter(data: data, labels: labels),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;

  LineChartPainter({required this.data, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = Colors.purple[400]!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = Colors.purple.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final textStyle = TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontSize: 12,
    );

    // Calculate dimensions
    final chartHeight = size.height - 30; // Leave space for labels
    final chartWidth = size.width - 60; // Leave space for Y-axis labels
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = 0;

    // Draw Y-axis labels
    for (int i = 0; i <= 5; i++) {
      final value = minValue + (maxValue - minValue) * i / 5;
      final y = chartHeight - (chartHeight * i / 5);

      final textPainter = TextPainter(
        text: TextSpan(text: value.toInt().toString(), style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - textPainter.height / 2));
    }

    // Draw X-axis labels
    final labelWidth = chartWidth / labels.length;
    for (int i = 0; i < labels.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(60 + i * labelWidth - textPainter.width / 2, chartHeight + 5),
      );
    }

    // Calculate points for the line
    final points = <Offset>[];
    for (int i = 0; i < data.length; i++) {
      final x = 60 + (i * chartWidth / (data.length - 1));
      final normalizedValue = (data[i] - minValue) / (maxValue - minValue);
      final y = chartHeight - (normalizedValue * chartHeight);
      points.add(Offset(x, y));
    }

    // Draw filled area
    final path = Path();
    path.moveTo(points.first.dx, chartHeight);
    for (final point in points) {
      path.lineTo(point.dx, point.dy);
    }
    path.lineTo(points.last.dx, chartHeight);
    path.close();
    canvas.drawPath(path, fillPaint);

    // Draw line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, paint);

    // Draw points
    final pointPaint = Paint()
      ..color = Colors.purple[400]!
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
