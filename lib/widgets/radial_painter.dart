import 'dart:math';

import 'package:flutter/cupertino.dart';

class RadialPainter extends CustomPainter {
  final Color backgroundColor;
  final Color lineColor;
  final double percent;
  final double width;

  RadialPainter(
      {required this.backgroundColor,
      required this.lineColor,
      required this.width,
      required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint bgLine = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint completeLine = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double sweepAngle = 2 * pi * percent;
    canvas.drawCircle(center, radius, bgLine);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, completeLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
