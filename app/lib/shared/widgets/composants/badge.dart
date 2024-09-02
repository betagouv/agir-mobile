import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvBadge extends StatelessWidget {
  const FnvBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
  });

  final String label;
  final Color backgroundColor;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s0v5)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s1w),
          child: Text(
            label,
            style: const DsfrTextStyle.bodySmBold(color: Colors.white),
          ),
        ),
      );
}
