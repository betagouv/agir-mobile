import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

export 'button_icon_location.dart';
export 'button_size.dart';
export 'button_variant.dart';
export 'raw_button.dart';

class DsfrButton extends StatelessWidget {
  const DsfrButton({
    required this.label,
    this.icon,
    this.iconLocation = DsfrButtonIconLocation.left,
    this.iconColor,
    required this.variant,
    required this.size,
    this.onPressed,
    super.key,
  });

  final IconData? icon;
  final String label;
  final DsfrButtonIconLocation iconLocation;
  final Color? iconColor;
  final DsfrButtonVariant variant;
  final DsfrButtonSize size;
  final VoidCallback? onPressed;

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
      var children = <Widget>[
        buttonIcon,
        const SizedBox(width: DsfrSpacings.s1w),
        Flexible(child: child),
      ];
      if (iconLocation == DsfrButtonIconLocation.right) {
        children = children.reversed.toList();
      }

      child = Row(mainAxisSize: MainAxisSize.min, children: children);
    }

    if (iconColor != null) {
      child = IconTheme(data: IconThemeData(color: iconColor), child: child);
    }

    return DsfrRawButton(
      variant: variant,
      size: size,
      onTap: onPressed,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.textScalerOf(context).scale(DsfrSpacings.s3w),
          ),
          child: child,
        ),
      ),
    );
  }
}
