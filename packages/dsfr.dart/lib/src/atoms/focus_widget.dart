import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrFocusWidget extends StatelessWidget {
  const DsfrFocusWidget({
    super.key,
    required this.isFocused,
    this.borderRadius,
    required this.child,
  });

  final bool isFocused;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border:
          isFocused
              ? const Border.fromBorderSide(
                BorderSide(
                  color: DsfrColors.focus525,
                  width: DsfrSpacings.s0v5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              )
              : null,
      borderRadius: borderRadius?.add(
        const BorderRadius.all(Radius.circular(DsfrSpacings.s0v5)),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s0v5),
      child: child,
    ),
  );
}
