import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class DsfrDivider extends StatelessWidget {
  const DsfrDivider({
    this.width,
    this.height = 1,
    this.color = DsfrColors.grey900,
    this.alignment = Alignment.center,
    super.key,
  });

  final double? width;
  final double height;
  final Color color;
  final AlignmentGeometry alignment;

  @override
  Widget build(final context) => Align(
        alignment: alignment,
        child: SizedBox(
          width: width,
          child: Divider(height: height, thickness: height, color: color),
        ),
      );
}
