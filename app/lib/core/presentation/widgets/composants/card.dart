import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvCard extends StatelessWidget {
  const FnvCard({required this.child, this.onTap, super.key, this.borderColor});

  final Widget child;
  final GestureTapCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: FnvColors.carteFond,
          shadows: carteOmbre,
          shape: RoundedRectangleBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!),
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
