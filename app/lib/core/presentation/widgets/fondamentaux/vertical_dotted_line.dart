// ignore_for_file: avoid-unnecessary-type-assertions

import 'package:flutter/material.dart';

class VerticalDottedLine extends StatelessWidget {
  const VerticalDottedLine({super.key});

  @override
  Widget build(final context) => const CustomPaint(painter: _Painter());
}

class _Painter extends CustomPainter {
  const _Painter();

  static const _dashHeight = 4.0;
  static const _dashSpace = 4;
  static const _dashWidth = 2.0;
  static const _color = Color(0xFFBABABA);

  @override
  void paint(final Canvas canvas, final Size size) {
    final paint = Paint()
      ..color = _color
      ..strokeWidth = _dashWidth;

    final dashCount = (size.height / (_dashHeight + _dashSpace)).ceil();
    for (var i = 0; i < dashCount; i++) {
      final startY = i * (_dashHeight + _dashSpace);
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + _dashHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => false;
}
