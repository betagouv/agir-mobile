import 'package:app/src/design_system/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvBottomBar extends StatelessWidget {
  const FnvBottomBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(),
          shadows: bottomNavigationBarOmbre,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DsfrSpacings.s2w,
            vertical: DsfrSpacings.s3w,
          ),
          child: SizedBox(
            height: DsfrSpacings.s6w,
            child: child,
          ),
        ),
      );
}
