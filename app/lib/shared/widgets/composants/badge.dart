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
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1v)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
          child: Text(
            label,
            style: DsfrTextStyle.bodySmBold(color: foregroundColor),
          ),
        ),
      );
}
