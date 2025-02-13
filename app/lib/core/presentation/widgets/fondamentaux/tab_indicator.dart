import 'package:flutter/material.dart';

class DsfrTabIndicator extends Decoration {
  const DsfrTabIndicator({
    this.borderSide = const BorderSide(color: Colors.white, width: 2),
    this.insets = EdgeInsets.zero,
  });
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(final Decoration? a, final double t) =>
      a is DsfrTabIndicator
          ? DsfrTabIndicator(
            borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
            insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
          )
          : super.lerpFrom(a, t);

  @override
  Decoration? lerpTo(final Decoration? b, final double t) =>
      b is DsfrTabIndicator
          ? DsfrTabIndicator(
            borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
            insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
          )
          : super.lerpTo(b, t);

  @override
  BoxPainter createBoxPainter([final VoidCallback? onChanged]) =>
      _AboveLinePainter(this, onChanged);

  Rect indicatorRectFor(final Rect rect, final TextDirection textDirection) {
    final indicator = insets.resolve(textDirection).deflateRect(rect);

    return Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      borderSide.width,
    );
  }

  @override
  Path getClipPath(final Rect rect, final TextDirection textDirection) =>
      Path()..addRect(indicatorRectFor(rect, textDirection));
}

class _AboveLinePainter extends BoxPainter {
  const _AboveLinePainter(this.decoration, super.onChanged);

  final DsfrTabIndicator decoration;

  @override
  void paint(
    final Canvas canvas,
    final Offset offset,
    final ImageConfiguration configuration,
  ) {
    assert(configuration.size != null, 'configuration.size is null');
    final rect = offset & configuration.size!;
    final textDirection = configuration.textDirection!;
    final paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.square;
    final indicator = decoration
        .indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2.0);

    final backgroundPaint = Paint()..color = Colors.white;
    canvas
      ..drawRect(rect, backgroundPaint)
      ..drawLine(indicator.topLeft, indicator.topRight, paint);
  }
}
