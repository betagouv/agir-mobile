import 'package:dsfr/src/composants/buttons/button.dart';
import 'package:dsfr/src/composants/buttons/button_background_color.dart';
import 'package:dsfr/src/composants/buttons/button_border.dart';
import 'package:dsfr/src/composants/buttons/button_foreground_color.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRawButton extends StatefulWidget {
  const DsfrRawButton({
    required this.child,
    required this.variant,
    this.foregroundColor,
    required this.size,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  final Widget child;
  final DsfrButtonVariant variant;
  final Color? foregroundColor;
  final DsfrButtonSize size;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  @override
  State<DsfrRawButton> createState() => _DsfrRawButtonState();
}

class _DsfrRawButtonState extends State<DsfrRawButton>
    with MaterialStateMixin<DsfrRawButton> {
  static const _focusBorderWidth = 2.0;
  static const _focusPadding = EdgeInsets.all(4);
  late final double _minHeight;
  late final EdgeInsetsGeometry _padding;
  late final TextStyle _textStyle;
  late final DsfrButtonBackgroundColor _backgroundColor;
  late final DsfrButtonForegroundColor _foregroundColor;
  late final DsfrButtonBorder _border;

  @override
  void initState() {
    super.initState();
    _backgroundColor = DsfrButtonBackgroundColor.fromVariant(widget.variant);
    _foregroundColor = widget.foregroundColor == null
        ? DsfrButtonForegroundColor.fromVariant(widget.variant)
        : DsfrButtonForegroundColor(
            $default: widget.foregroundColor!,
            disabled: DsfrColors.grey625,
          );
    _border = widget.foregroundColor == null
        ? DsfrButtonBorder.fromVariant(widget.variant)
        : DsfrButtonBorder(
            $default: Border.fromBorderSide(
              BorderSide(color: widget.foregroundColor!),
            ),
            disabled: const Border.fromBorderSide(
              BorderSide(color: DsfrColors.grey925),
            ),
          );
    _padding = _getPadding(widget.size);
    _textStyle = _getTextStyle(widget.size);
    _minHeight = _getMinHeight(widget.size);
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  EdgeInsetsGeometry _getPadding(final DsfrButtonSize size) => switch (size) {
        DsfrButtonSize.lg =>
          const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        DsfrButtonSize.md =>
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        DsfrButtonSize.sm =>
          const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      };

  TextStyle _getTextStyle(final DsfrButtonSize size) => switch (size) {
        DsfrButtonSize.lg => const DsfrTextStyle.bodyLgMedium(),
        DsfrButtonSize.md => const DsfrTextStyle.bodyMdMedium(),
        DsfrButtonSize.sm => const DsfrTextStyle.bodySmMedium(),
      };

  double _getMinHeight(final DsfrButtonSize size) => switch (size) {
        DsfrButtonSize.lg => DsfrSpacings.s6w,
        DsfrButtonSize.md => DsfrSpacings.s5w,
        DsfrButtonSize.sm => DsfrSpacings.s4w,
      };

  @override
  void didUpdateWidget(final DsfrRawButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  Widget build(final BuildContext context) {
    final textColor = _foregroundColor.resolve(materialStates);
    final button = Semantics(
      enabled: widget.onTap != null,
      button: true,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        canRequestFocus: widget.onTap != null,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: _minHeight),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _backgroundColor.resolve(materialStates),
              border: _border.resolve(materialStates),
              borderRadius: widget.borderRadius,
            ),
            child: Padding(
              padding: _padding,
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: IconTheme(
                  data: IconThemeData(color: textColor),
                  child: DefaultTextStyle(
                    style: _textStyle.copyWith(color: textColor),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return isFocused
        ? DecoratedBox(
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  color: DsfrColors.focus525,
                  width: _focusBorderWidth,
                ),
              ),
            ),
            child: Padding(padding: _focusPadding, child: button),
          )
        : button;
  }
}
