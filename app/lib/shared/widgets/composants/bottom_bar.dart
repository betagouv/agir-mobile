// ignore_for_file: avoid-single-child-column-or-row

import 'package:app/shared/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvBottomBar extends StatelessWidget {
  const FnvBottomBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) => SafeArea(
        left: false,
        top: false,
        right: false,
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            shadows: bottomNavigationBarOmbre,
            shape: RoundedRectangleBorder(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DsfrSpacings.s3v,
                  horizontal: DsfrSpacings.s2w,
                ),
                child: child,
              ),
            ],
          ),
        ),
      );
}
