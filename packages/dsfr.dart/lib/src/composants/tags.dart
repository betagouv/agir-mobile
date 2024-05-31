import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrTag extends StatelessWidget {
  const DsfrTag._({
    required this.label,
    required this.textStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.padding,
    super.key,
  });

  const DsfrTag.sm({
    required final String label,
    required final Color backgroundColor,
    required final Color foregroundColor,
    final Key? key,
  }) : this._(
          label: label,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: DsfrFonts.bodyXs,
          padding: const EdgeInsets.symmetric(
            horizontal: DsfrSpacings.s1w,
            vertical: DsfrSpacings.s0v5,
          ),
          key: key,
        );

  final String label;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsets padding;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: backgroundColor,
        ),
        child: Padding(
          padding: padding,
          child: Text(
            label,
            style: textStyle.copyWith(color: foregroundColor),
          ),
        ),
      );
}
