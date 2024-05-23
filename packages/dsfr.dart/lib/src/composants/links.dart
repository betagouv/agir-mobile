import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrLink extends StatefulWidget {
  const DsfrLink._({
    required this.label,
    required this.textStyle,
    required this.focusBorderWidth,
    required this.focusPadding,
    this.onTap,
    super.key,
  });

  const DsfrLink.md({
    required final String label,
    final VoidCallback? onTap,
    final Key? key,
  }) : this._(
          label: label,
          textStyle: DsfrFonts.bodyMd,
          focusBorderWidth: 2,
          focusPadding: const EdgeInsets.all(4),
          onTap: onTap,
          key: key,
        );

  final String label;
  final VoidCallback? onTap;
  final TextStyle textStyle;
  final double focusBorderWidth;
  final EdgeInsetsGeometry focusPadding;

  @override
  State<DsfrLink> createState() => _DsfrLinkState();
}

class DsfrLinkForegroundColor extends WidgetStateColor {
  DsfrLinkForegroundColor() : super(_default.value);

  static const Color _default = DsfrColors.blueFranceSun113;
  static const Color _disabled = DsfrColors.grey625;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _disabled;
    }
    return _default;
  }
}

class DsfrLinkBackgroundColor extends WidgetStateColor {
  DsfrLinkBackgroundColor() : super(_default.value);

  static const Color _default = Colors.transparent;
  static const Color _active = Color(0x21000000); // Noir 8%;

  @override
  Color resolve(final Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return _active;
    }
    return _default;
  }
}

class _DsfrLinkState extends State<DsfrLink> with MaterialStateMixin<DsfrLink> {
  final foregroundColor = DsfrLinkForegroundColor();
  final backgroundColor = DsfrLinkBackgroundColor();

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
    final Widget link = Semantics(
      link: true,
      enabled: widget.onTap != null,
      child: InkWell(
        onFocusChange: updateMaterialState(WidgetState.focused),
        onHover: updateMaterialState(WidgetState.hovered),
        onHighlightChanged: updateMaterialState(WidgetState.pressed),
        onTap: widget.onTap,
        canRequestFocus: widget.onTap != null,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: !isFocused && !isDisabled
                ? Border(
                    bottom: BorderSide(
                      color: foregroundColor.resolve(materialStates),
                      width: isPressed || isHovered ? 2 : 1,
                    ),
                  )
                : null,
          ),
          child: Text(
            widget.label,
            style: widget.textStyle.copyWith(
              color: foregroundColor.resolve(materialStates),
              backgroundColor: backgroundColor.resolve(materialStates),
            ),
          ),
        ),
      ),
    );

    if (!isFocused) {
      return link;
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
        child: link,
      ),
    );
  }
}
