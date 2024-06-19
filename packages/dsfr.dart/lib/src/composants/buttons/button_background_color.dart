import 'package:dsfr/src/composants/buttons/button_variant.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class DsfrButtonBackgroundColor extends WidgetStateColor {
  DsfrButtonBackgroundColor({
    required final Color $default,
    required final Color active,
    required final Color hover,
    required final Color disabled,
  })  : _default = $default,
        _active = active,
        _hover = hover,
        _disabled = disabled,
        super($default.value);

  factory DsfrButtonBackgroundColor.fromVariant(
    final DsfrButtonVariant variant,
  ) {
    switch (variant) {
      case DsfrButtonVariant.primary:
        return DsfrButtonBackgroundColor(
          $default: DsfrColors.blueFranceSun113,
          active: DsfrColors.blueFranceSun113Active,
          hover: DsfrColors.blueFranceSun113Hover,
          disabled: DsfrColors.grey925,
        );

      case DsfrButtonVariant.secondary:
      case DsfrButtonVariant.tertiary:
      case DsfrButtonVariant.tertiaryWithouBorder:
        return DsfrButtonBackgroundColor(
          $default: Colors.transparent,
          active: const Color(0x0A000000),
          hover: const Color(0x14000000),
          disabled: Colors.transparent,
        );
    }
  }

  final Color _default;
  final Color _active;
  final Color _hover;
  final Color _disabled;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _disabled;
    }
    if (states.contains(WidgetState.pressed)) {
      return _active;
    }

    return states.contains(WidgetState.hovered) ? _hover : _default;
  }
}
