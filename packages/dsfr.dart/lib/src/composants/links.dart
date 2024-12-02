import 'package:dsfr/src/composants/link_icon_position.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrLink extends StatefulWidget {
  const DsfrLink._({
    super.key,
    required this.label,
    required this.textStyle,
    required this.underlineThickness,
    required this.focusBorderWidth,
    required this.focusPadding,
    required this.iconSize,
    required this.iconPosition,
    this.icon,
    this.onTap,
  });

  const DsfrLink.sm({
    required final String label,
    final IconData? icon,
    final DsfrLinkIconPosition iconPosition = DsfrLinkIconPosition.start,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          key: key,
          label: label,
          textStyle: const DsfrTextStyle.bodySm(),
          underlineThickness: 1.75,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          iconSize: 16,
          iconPosition: iconPosition,
          icon: icon,
          onTap: onTap,
        );

  const DsfrLink.md({
    required final String label,
    final IconData? icon,
    final DsfrLinkIconPosition iconPosition = DsfrLinkIconPosition.start,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          key: key,
          label: label,
          textStyle: const DsfrTextStyle.bodyMd(),
          underlineThickness: 2,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          iconSize: 16,
          iconPosition: iconPosition,
          icon: icon,
          onTap: onTap,
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

class _DsfrLinkState extends State<DsfrLink> with MaterialStateMixin<DsfrLink> {
  final _foregroundColor = DsfrLinkForegroundColor();

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
  Widget build(final context) {
    final resolveForegroundColor = _foregroundColor.resolve(materialStates);

    final list = [
      if (widget.icon != null) ...[
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(
            widget.icon,
            size: widget.iconSize,
            color: resolveForegroundColor,
          ),
        ),
        const WidgetSpan(child: SizedBox(width: DsfrSpacings.s1w)),
      ],
      TextSpan(text: widget.label),
    ];

    final link = Semantics(
      enabled: widget.onTap != null,
      link: true,
      child: InkWell(
        onTap: widget.onTap,
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onHover: updateMaterialState(WidgetState.hovered),
        highlightColor: const Color(0x21000000),
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
                  ? list
                  : list.reversed.toList(),
            ),
            style: widget.textStyle.copyWith(color: resolveForegroundColor),
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
