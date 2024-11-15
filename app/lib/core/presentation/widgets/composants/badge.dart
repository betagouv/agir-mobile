import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvBadge extends StatelessWidget {
  const FnvBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.foregroundColor = Colors.white,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(final context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DsfrSpacings.s0v5,
            horizontal: DsfrSpacings.s1w,
          ),
          child: Text(
            label,
            style: DsfrTextStyle.bodySmBold(color: foregroundColor),
          ),
        ),
      );
}
