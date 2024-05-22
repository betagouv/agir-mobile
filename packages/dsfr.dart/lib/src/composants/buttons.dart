import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrButton extends StatefulWidget {
  const DsfrButton._({
    required this.padding,
    required this.label,
    required this.textStyle,
    required this.focusBorderWidth,
    required this.focusPadding,
    this.onTap,
    super.key,
  });

  const DsfrButton.lg({
    required final String label,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          label: label,
          textStyle: DsfrFonts.bodyLgMedium,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          onTap: onTap,
          key: key,
        );

  final String label;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double focusBorderWidth;
  final EdgeInsetsGeometry focusPadding;

  @override
  State<DsfrButton> createState() => _DsfrButtonState();
}

class DsfrButtonBackgroundColor extends WidgetStateColor {
  DsfrButtonBackgroundColor() : super(_default.value);

  static const Color _default = DsfrColors.blueFranceSun113;
  static const Color _active = DsfrColors.blueFranceSun113Active;
  static const Color _hover = DsfrColors.blueFranceSun113Hover;
  static const Color _disabled = DsfrColors.grey925;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _disabled;
    }
    if (states.contains(WidgetState.pressed)) {
      return _active;
    }
    if (states.contains(WidgetState.hovered)) {
      return _hover;
    }
    return _default;
  }
}

class DsfrButtonForegroundColor extends WidgetStateColor {
  DsfrButtonForegroundColor() : super(_default.value);

  static const Color _default = DsfrColors.blueFrance975;
  static const Color _disabled = DsfrColors.grey625;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _disabled;
    }
    return _default;
  }
}

class _DsfrButtonState extends State<DsfrButton>
    with MaterialStateMixin<DsfrButton> {
  final backgroundColor = DsfrButtonBackgroundColor();
  final foregroundColor = DsfrButtonForegroundColor();

  @override
  void initState() {
    super.initState();
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  void didUpdateWidget(final DsfrButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  Widget build(final BuildContext context) {
    final Widget button = Semantics(
      button: true,
      enabled: widget.onTap != null,
      child: InkWell(
        onFocusChange: updateMaterialState(WidgetState.focused),
        onHover: updateMaterialState(WidgetState.hovered),
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onTap: widget.onTap,
        canRequestFocus: widget.onTap != null,
        child: ColoredBox(
          color: backgroundColor.resolve(materialStates),
          child: Padding(
            padding: widget.padding,
            child: Text(
              widget.label,
              style: widget.textStyle
                  .copyWith(color: foregroundColor.resolve(materialStates)),
            ),
          ),
        ),
      ),
    );

    if (!isFocused) {
      return button;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: DsfrColors.focus525,
            width: widget.focusBorderWidth,
          ),
        ),
      ),
      child: Padding(
        padding: widget.focusPadding,
        child: button,
      ),
    );
  }
}
