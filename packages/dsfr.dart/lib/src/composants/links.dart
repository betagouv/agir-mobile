import 'package:dsfr/src/composants/link_icon_position.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrLink extends StatefulWidget {
  const DsfrLink._({
    required this.label,
    required this.textStyle,
    required this.underlineThickness,
    required this.focusBorderWidth,
    required this.focusPadding,
    required this.iconSize,
    required this.iconPosition,
    this.icon,
    this.onTap,
    super.key,
  });

  const DsfrLink.sm({
    required final String label,
    final IconData? icon,
    final DsfrLinkIconPosition iconPosition = DsfrLinkIconPosition.start,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          label: label,
          textStyle: DsfrFonts.bodySm,
          underlineThickness: 1.75,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          iconSize: 16,
          iconPosition: iconPosition,
          icon: icon,
          onTap: onTap,
          key: key,
        );

  const DsfrLink.md({
    required final String label,
    final IconData? icon,
    final DsfrLinkIconPosition iconPosition = DsfrLinkIconPosition.start,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          label: label,
          textStyle: DsfrFonts.bodyMd,
          underlineThickness: 2,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          iconSize: 16,
          iconPosition: iconPosition,
          icon: icon,
          onTap: onTap,
          key: key,
        );

  final String label;
  final IconData? icon;
  final double iconSize;
  final DsfrLinkIconPosition iconPosition;
  final VoidCallback? onTap;
  final TextStyle textStyle;
  final double underlineThickness;
  final double focusBorderWidth;
  final EdgeInsetsGeometry focusPadding;

  @override
  State<DsfrLink> createState() => _DsfrLinkState();
}

class DsfrLinkForegroundColor extends WidgetStateColor {
  DsfrLinkForegroundColor() : super(_default.value);

  static const _default = DsfrColors.blueFranceSun113;
  static const _disabled = DsfrColors.grey625;

  @override
  Color resolve(final Set<WidgetState> states) =>
      states.contains(WidgetState.disabled) ? _disabled : _default;
}

class DsfrLinkBackgroundColor extends WidgetStateColor {
  DsfrLinkBackgroundColor() : super(_default.value);

  static const _default = Colors.transparent;
  static const _active = Color(0x21000000);
  @override
  Color resolve(final Set<WidgetState> states) =>
      states.contains(WidgetState.pressed) ? _active : _default;
}

class _DsfrLinkState extends State<DsfrLink> with MaterialStateMixin<DsfrLink> {
  final _foregroundColor = DsfrLinkForegroundColor();
  final _backgroundColor = DsfrLinkBackgroundColor();

  @override
  void initState() {
    super.initState();
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  void didUpdateWidget(final DsfrLink oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(WidgetState.disabled, widget.onTap == null);
  }

  @override
  Widget build(final BuildContext context) {
    final resolveForegroundColor = _foregroundColor.resolve(materialStates);
    final link = Semantics(
      enabled: widget.onTap != null,
      link: true,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        canRequestFocus: widget.onTap != null,
        onFocusChange: updateMaterialState(WidgetState.focused),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: !isFocused && !isDisabled
                ? Border(
                    bottom: BorderSide(
                      color: resolveForegroundColor,
                      width: isPressed || isHovered
                          ? widget.underlineThickness
                          : 1,
                    ),
                  )
                : null,
          ),
          child: Text.rich(
            TextSpan(
              children: widget.iconPosition == DsfrLinkIconPosition.start
                  ? [
                      if (widget.icon != null) ...[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            widget.icon,
                            size: widget.iconSize,
                            color: resolveForegroundColor,
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: DsfrSpacings.s1w),
                        ),
                      ],
                      TextSpan(text: widget.label),
                    ]
                  : [
                      TextSpan(text: widget.label),
                      if (widget.icon != null) ...[
                        const WidgetSpan(
                          child: SizedBox(width: DsfrSpacings.s1w),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            widget.icon,
                            size: widget.iconSize,
                            color: resolveForegroundColor,
                          ),
                        ),
                      ],
                    ],
            ),
            style: widget.textStyle.copyWith(
              color: resolveForegroundColor,
              backgroundColor: _backgroundColor.resolve(materialStates),
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
            child: Padding(padding: widget.focusPadding, child: link),
          )
        : link;
  }
}
