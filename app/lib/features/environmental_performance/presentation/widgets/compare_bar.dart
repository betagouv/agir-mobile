import 'package:flutter/material.dart';

class CompareBar extends StatelessWidget {
  const CompareBar({super.key, required this.value})
      : assert(value >= 0 && value <= 1, 'Value must be between 0.0 and 1.0');

  final double value;

  @override
  Widget build(final BuildContext context) => CustomPaint(
        painter: _RainbowCompareIndicatorPainter(value: value),
        size: const Size(double.infinity, 44),
      );
}

class _RainbowCompareIndicatorPainter extends CustomPainter {
  const _RainbowCompareIndicatorPainter({required this.value});

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

  static const _trackHeight = 16.0;
  static const _trackPaddingTop = 14.0;
  static const _triangleSize = Size(14, 12.12);

  @override
  void paint(final Canvas canvas, final Size size) {
    _drawTrack(canvas, size);
    _drawProgressBar(canvas, size);
    _drawMarkers(canvas, size);
  }

  void _drawTrack(final Canvas canvas, final Size size) {
    final track = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, _trackPaddingTop, size.width, _trackHeight),
      Radius.circular(size.height),
    );
    final trackPaint = Paint()..color = const Color(0x80C2C2C2);
    canvas.drawRRect(track, trackPaint);
  }

  void _drawProgressBar(final Canvas canvas, final Size size) {
    final progressWidth = value * size.width;
    if (progressWidth <= 0.0) {
      return;
    }
    final progressBar = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, _trackPaddingTop, progressWidth, _trackHeight),
      Radius.circular(size.height),
    );
    final progressPaint = Paint()
      ..shader = _progressGradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(progressBar, progressPaint);
  }

  void _drawMarkers(final Canvas canvas, final Size size) {
    _drawUpperTriangleMarker(
      value,
      canvas: canvas,
      totalSize: size,
      topY: 0,
      size: _triangleSize,
    );
    _drawLowerTriangleMarker(
      9.12 / 12,
      canvas: canvas,
      totalSize: size,
      topY: 14 + 16.0,
      size: _triangleSize,
    );
  }

  void _drawUpperTriangleMarker(
    final double position, {
    required final Canvas canvas,
    required final Size totalSize,
    required final double topY,
    required final Size size,
  }) {
    final centerX = position * totalSize.width;
    final bottomY = topY + size.height;
    final halfWidth = size.width / 2;
    final path = Path()
      ..moveTo(centerX, bottomY)
      ..lineTo(centerX - halfWidth, topY)
      ..lineTo(centerX + halfWidth, topY)
      ..close();

    final paint = Paint()
      ..shader = _progressGradient.createShader(Offset.zero & totalSize)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  void _drawLowerTriangleMarker(
    final double position, {
    required final Canvas canvas,
    required final Size totalSize,
    required final double topY,
    required final Size size,
  }) {
    final centerX = position * totalSize.width;
    final halfWidth = size.width / 2;
    final bottomY = topY + size.height;
    final path = Path()
      ..moveTo(centerX, topY)
      ..lineTo(centerX - halfWidth, bottomY)
      ..lineTo(centerX + halfWidth, bottomY)
      ..close();

    final paint = Paint()
      ..shader = _progressGradient.createShader(Offset.zero & totalSize)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(final _RainbowCompareIndicatorPainter oldPainter) =>
      oldPainter.value != value;
}
