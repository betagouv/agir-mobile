import 'package:flutter/material.dart';

/// A custom progress bar widget that displays a rainbow gradient.
///
/// The [value] parameter represents the progress and must be between 0.0 and 1.0, inclusive.
class ProgressBar extends StatelessWidget {
  /// Creates a progress bar.
  ///
  /// The [value] must be between 0.0 and 1.0, inclusive.
  const ProgressBar({super.key, required this.value})
      : assert(
          value >= 0 && value <= 1,
          'Value must be between 0.0 and 1.0',
        );

  /// The progress value, from 0.0 to 1.0.
  final double value;

  @override
  Widget build(final BuildContext context) => CustomPaint(
        painter: _Painter(value: value),
        size: const Size(double.infinity, 6),
      );
}

class _Painter extends CustomPainter {
  const _Painter({required this.value});

  final double value;

  static const _color = Color(0xFFDF1451);

  @override
  void paint(final Canvas canvas, final Size size) {
    final width = value * size.width;
    if (width <= 0.0) {
      return;
    }

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, size.height),
      Radius.circular(size.height),
    );

    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
