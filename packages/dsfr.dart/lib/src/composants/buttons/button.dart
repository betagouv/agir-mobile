// ignore_for_file: omit_local_variable_types

import 'package:dsfr/src/composants/buttons/button_icon_location.dart';
import 'package:dsfr/src/composants/buttons/button_size.dart';
import 'package:dsfr/src/composants/buttons/button_variant.dart';
import 'package:dsfr/src/composants/buttons/raw_button.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

export 'button_icon_location.dart';
export 'button_size.dart';
export 'button_variant.dart';

class DsfrButton extends StatelessWidget {
  const DsfrButton({
    required this.label,
    this.icon,
    this.iconLocation = DsfrButtonIconLocation.left,
    required this.variant,
    required this.size,
    this.onTap,
    super.key,
  });

  final IconData? icon;
  final String label;
  final DsfrButtonIconLocation iconLocation;
  final DsfrButtonVariant variant;
  final DsfrButtonSize size;
  final VoidCallback? onTap;

  double _getSize(final DsfrButtonSize size) {
    switch (size) {
      case DsfrButtonSize.lg:
        return DsfrSpacings.s3w;

      case DsfrButtonSize.md:
      case DsfrButtonSize.sm:
        return DsfrSpacings.s2w;
    }
  }

  @override
  Widget build(final BuildContext context) {
    Widget child = Text(label);
    if (icon != null) {
      final buttonIcon = Icon(icon, size: _getSize(size));
      List<Widget> children = [
        buttonIcon,
        const SizedBox(width: DsfrSpacings.s1w),
        Flexible(child: child),
      ];
      if (iconLocation == DsfrButtonIconLocation.right) {
        children = children.reversed.toList();
      }

      child = Row(mainAxisSize: MainAxisSize.min, children: children);
    }

    return DsfrRawButton(
      variant: variant,
      size: size,
      onTap: onTap,
      child: Center(
        child: SizedBox(
          height: MediaQuery.textScalerOf(context).scale(DsfrSpacings.s3w),
          child: child,
        ),
      ),
    );
  }
}
