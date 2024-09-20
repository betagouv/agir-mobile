import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButton<T> extends StatelessWidget {
  const DsfrRadioButton({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.backgroundColor,
    super.key,
  });

  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color? backgroundColor;

  void _handleChange() => onChanged(value);

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: _handleChange,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.fromBorderSide(
              BorderSide(
                color: groupValue == value
                    ? DsfrColors.blueFranceSun113
                    : DsfrColors.grey900,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioIcon(
                  key: ValueKey(title),
                  value: value,
                  groupValue: groupValue,
                ),
                const SizedBox(width: DsfrSpacings.s1w),
                Flexible(
                  child: Text(title, style: const DsfrTextStyle.bodyMd()),
                ),
              ],
            ),
          ),
        ),
      );
}

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
            size: const Size(24, 24),
            painter: _RadioIconPainter(isSelected: groupValue == value),
          ),
        ),
      );
}

class _RadioIconPainter extends CustomPainter {
  _RadioIconPainter({required this.isSelected});

  final bool isSelected;
  static const double outerRadius = 11;
  static const double innerRadius = 6;

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
