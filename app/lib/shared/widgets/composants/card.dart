import 'package:app/shared/widgets/fondamentaux/colors.dart';
import 'package:app/shared/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:flutter/material.dart';

class FnvCard extends StatelessWidget {
  const FnvCard({required this.child, this.onTap, super.key});

  final Widget child;
  final GestureTapCallback? onTap;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: FnvColors.carteFond,
          shadows: carteOmbre,
          shape: roundedRectangleBorder,
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
