import 'package:flutter/material.dart';

class CompareBar extends StatelessWidget {
  const CompareBar({super.key, required this.value});

  final double value;

  @override
  Widget build(final context) => CustomPaint(
    painter: _Painter(value: value),
    size: const Size(double.infinity, 12),
  );
}

class _Painter extends CustomPainter {
  const _Painter({required this.value});

  final double value;

  static const _progressGradient = LinearGradient(
    colors: [
      Color(0xFFA6DD00),
      Color(0xFFFF9D00),
      Color(0xFFDF1451),
      Color(0xFFDF1451),
    ],
    stops: [0.17, 0.562, 0.995, 1.0],
  );

  @override
  void paint(final Canvas canvas, final Size size) {
    _drawTrack(canvas, size);
    _drawProgressBar(canvas, size);
  }

  void _drawTrack(final Canvas canvas, final Size size) {
    final track = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.height),
    );
    final trackPaint = Paint()..color = const Color(0x80C2C2C2);
    canvas.drawRRect(track, trackPaint);
  }

  void _drawProgressBar(final Canvas canvas, final Size size) {
    final progressWidth = value.clamp(0, 1) * size.width;
    if (progressWidth <= 0.0) {
      return;
    }
    final progressBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, progressWidth, size.height),
      Radius.circular(size.height),
    );
    final progressPaint =
        Paint()
          ..shader = _progressGradient.createShader(Offset.zero & size)
          ..style = PaintingStyle.fill;
    canvas.drawRRect(progressBar, progressPaint);
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
