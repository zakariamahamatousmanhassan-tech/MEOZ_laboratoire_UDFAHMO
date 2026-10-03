import 'package:flutter/material.dart';

class IslamicPatternPainter extends CustomPainter {
  final Color color;
  const IslamicPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const step = 56.0;
    const r = 20.0;
    for (double y = 0; y < size.height + step; y += step) {
      for (double x = 0; x < size.width + step; x += step) {
        canvas.save();
        canvas.translate(x, y);
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: r * 2, height: r * 2), p);
        canvas.rotate(0.785398);
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: r * 2, height: r * 2), p);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
