import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class RadioIcon<T> extends StatelessWidget {
  const RadioIcon({
    super.key,
    required this.value,
    required this.groupValue,
  });

  final T value;
  final T? groupValue;

  @override
  Widget build(final BuildContext context) => Semantics(
        checked: groupValue == value,
        selected: groupValue == value,
        inMutuallyExclusiveGroup: true,
        child: FittedBox(
          child: CustomPaint(
            painter: _RadioIconPainter(isSelected: groupValue == value),
            size: const Size(24, 24),
          ),
        ),
      );
}

class _RadioIconPainter extends CustomPainter {
  const _RadioIconPainter({required this.isSelected});

  final bool isSelected;
  static const outerRadius = 11.0;
  static const innerRadius = 6.0;

  @override
  void paint(final Canvas canvas, final Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..color = DsfrColors.blueFranceSun113
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, outerRadius, paint);

    if (isSelected) {
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(center, innerRadius, paint);
    }
  }

  @override
  bool shouldRepaint(final _RadioIconPainter oldDelegate) =>
      isSelected != oldDelegate.isSelected;
}
