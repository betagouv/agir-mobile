import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class QuestionsProgressBar extends StatelessWidget {
  const QuestionsProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(final BuildContext context) => Semantics(
        label: 'Question $current sur $total',
        child: CustomPaint(
          painter: _Painter(value: current / total),
          size: const Size(double.infinity, 8),
        ),
      );
}

class _Painter extends CustomPainter {
  const _Painter({required this.value});

  final double value;

  static const _color = DsfrColors.blueFranceSun113;

  @override
  void paint(final Canvas canvas, final Size size) {
    _drawTrack(canvas, size);
    _drawProgress(canvas, size);
  }

  void _drawTrack(final Canvas canvas, final Size size) {
    final track = Rect.fromLTWH(0, 0, size.width, size.height);
    final trackPaint = Paint()..color = const Color(0x80C2C2C2);
    canvas.drawRect(track, trackPaint);
  }

  void _drawProgress(final Canvas canvas, final Size size) {
    final width = value.clamp(0, 1) * size.width;
    if (width <= 0.0) {
      return;
    }

    final rect = Rect.fromLTWH(0, 0, width, size.height);
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(final _Painter oldPainter) => oldPainter.value != value;
}
