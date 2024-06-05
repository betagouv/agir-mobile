import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
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

  static const _default = DsfrColors.blueFranceSun113;
  static const _active = DsfrColors.blueFranceSun113Active;
  static const _hover = DsfrColors.blueFranceSun113Hover;
  static const _disabled = DsfrColors.grey925;

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

class DsfrButtonForegroundColor extends WidgetStateColor {
  DsfrButtonForegroundColor() : super(_default.value);

  static const _default = DsfrColors.blueFrance975;
  static const _disabled = DsfrColors.grey625;

  @override
  Color resolve(final Set<WidgetState> states) =>
      states.contains(WidgetState.disabled) ? _disabled : _default;
}

class _DsfrButtonState extends State<DsfrButton>
    with MaterialStateMixin<DsfrButton> {
  final _backgroundColor = DsfrButtonBackgroundColor();
  final _foregroundColor = DsfrButtonForegroundColor();

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
    final button = Semantics(
      enabled: widget.onTap != null,
      button: true,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        canRequestFocus: widget.onTap != null,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: ColoredBox(
          color: _backgroundColor.resolve(materialStates),
          child: Padding(
            padding: widget.padding,
            child: Center(
              child: Text(
                widget.label,
                style: widget.textStyle
                    .copyWith(color: _foregroundColor.resolve(materialStates)),
              ),
            ),
          ),
        ),
      ),
    );

    return isFocused
        ? DecoratedBox(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  color: DsfrColors.focus525,
                  width: widget.focusBorderWidth,
                ),
              ),
            ),
            child: Padding(padding: widget.focusPadding, child: button),
          )
        : button;
  }
}
