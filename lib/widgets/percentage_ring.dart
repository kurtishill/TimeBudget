import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_budget/models/category.dart';

class PercentageRing extends CustomPainter {
  final double radius;
  final List<Category> categories;
  final int timePeriodLengthInSeconds;

  PercentageRing({
    @required this.radius,
    @required this.categories,
    @required this.timePeriodLengthInSeconds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double totalPercentage = 0;

    // start painting from the top of the circle
    double startAngle = -pi / 2;

    // center of ring
    final center = Offset(size.width / 2, size.height / 2);

    int i = 0;
    while (totalPercentage < 1.0) {
      double percentage = 0;
      Color color;

      if (i < this.categories.length) {
        percentage =
            this.categories[i].amountOfTime / this.timePeriodLengthInSeconds;
        color = this.categories[i].color;
      } else {
        percentage = 1.0 - totalPercentage;
        color = Colors.grey;
      }

      totalPercentage += percentage;

      final sweepAngle = 2 * (pi / (1 / percentage));

      _drawArc(
        canvas,
        center,
        percentage,
        color,
        startAngle,
        sweepAngle,
      );

      if (i < this.categories.length &&
          this.categories[i].name != null &&
          this.categories[i].amountOfTime > 0) {
        _drawLabel(
          canvas,
          this.categories[i],
          center,
          startAngle + sweepAngle / 2,
          percentage,
        );
      }

      startAngle += sweepAngle;
      i += 1;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _drawArc(
    Canvas canvas,
    Offset center,
    double percentage,
    Color color,
    double startAngle,
    double sweepAngle,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final useCenter = false;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  void _drawLabel(
    Canvas canvas,
    Category label,
    Offset ringCenter,
    double angle,
    double percentage,
  ) {
    final dx = ringCenter.dx + radius * cos(angle);
    final dy = ringCenter.dy + radius * sin(angle);

    final nameLength = '${label.name} ${(percentage * 100).toStringAsFixed(1)}%'
        .length
        .toDouble();

    final textSpan = TextSpan(
      text: '${label.name} ${(percentage * 100).toStringAsFixed(1)}%',
      style: TextStyle(
        color: label.color,
        fontSize: 12,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: 120,
      );

    Offset nameOffset = Offset(0, 0);
    Offset lineOffset = Offset(0, 0);
    // final double nameLength = label.name.length.toDouble();

    // above center
    if ((ringCenter.dy - dy).sign >= 0) {
      // above and left
      if ((ringCenter.dx - dx).sign > 0) {
        nameOffset = Offset(-20 - nameLength, -20);
        lineOffset = Offset(-5, -3);

        // above and right
      } else {
        nameOffset = Offset(5 - nameLength * 3, -20);
        lineOffset = Offset(5, -4);
      }
      // below center
    } else {
      // below and left
      if ((ringCenter.dx - dx).sign >= 0) {
        nameOffset = Offset(5 - nameLength * 4, 5);
        lineOffset = Offset(-5, 3);

        // below and right
      } else {
        nameOffset = Offset(5 - nameLength * 3, 5);
        lineOffset = Offset(4, 4);
      }
    }

    final paint = Paint()
      ..strokeWidth = 1
      ..color = Colors.grey;

    final startPoint = Offset(dx + lineOffset.dx, dy + lineOffset.dy);
    final endPoint = Offset(
      dx + lineOffset.dx + 30 * cos(angle),
      dy + lineOffset.dy + 30 * sin(angle),
    );

    canvas.drawLine(
      startPoint,
      endPoint,
      paint,
    );

    textPainter.paint(canvas, endPoint + nameOffset);
  }
}
