import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvCard extends StatelessWidget {
  const FnvCard({super.key, required this.child, this.onTap, this.borderColor});

  final Widget child;
  final GestureTapCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(final context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: FnvColors.carteFond,
          shadows: carteOmbre,
          shape: RoundedRectangleBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!, width: DsfrSpacings.s0v5),
            borderRadius:
                const BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
          ),
        ),
        child: Material(
          color: FnvColors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius:
                roundedRectangleBorder.borderRadius.resolve(TextDirection.ltr),
            child: child,
          ),
        ),
      );
}
