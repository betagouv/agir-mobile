import 'package:flutter/material.dart';

/// A custom progress bar widget that displays a rainbow gradient.
///
/// The [value] parameter represents the progress and must be between 0.0 and 1.0, inclusive.
class RainbowProgressBar extends StatelessWidget {
  /// Creates a progress bar.
  ///
  /// The [value] must be between 0.0 and 1.0, inclusive.
  const RainbowProgressBar({super.key, required this.value});

  /// The progress value, from 0.0 to 1.0.
  final double value;

  @override
  Widget build(final context) => CustomPaint(
        painter: _Painter(value: value),
        size: const Size(double.infinity, 6),
      );
}

class _Painter extends CustomPainter {
  const _Painter({required this.value});

  final double value;

  static const _gradient = LinearGradient(
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
    final width = value.clamp(0, 1) * size.width;
    if (width <= 0.0) {
      return;
    }

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, size.height),
      Radius.circular(size.height),
    );

    final paint = Paint()
      ..shader = _gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
