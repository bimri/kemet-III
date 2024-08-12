import 'package:flutter/material.dart';
import 'dart:math' as math;

class GlobePainter extends CustomPainter {
  final double rotation;

  GlobePainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);

    // Draw longitude lines
    for (var i = 0; i < 24; i++) {
      final angle = i * math.pi / 12;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angle,
        math.pi,
        false,
        paint,
      );
    }

    // Draw latitude lines
    for (var i = 1; i < 6; i++) {
      final latRadius = radius * math.sin(i * math.pi / 12);
      canvas.drawCircle(center, latRadius, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}