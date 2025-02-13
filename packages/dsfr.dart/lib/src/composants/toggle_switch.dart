import 'package:dsfr/src/atoms/focus_widget.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrToggleSwitch extends StatefulWidget {
  const DsfrToggleSwitch({super.key, required this.label, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  State<DsfrToggleSwitch> createState() => _DsfrToggleSwitchState();
}

class _DsfrToggleSwitchState extends State<DsfrToggleSwitch> with MaterialStateMixin<DsfrToggleSwitch> {
  @override
  Widget build(final context) => Semantics(
    toggled: widget.value,
    child: InkWell(
      onTap: () => widget.onChanged(!widget.value),
      onHighlightChanged: updateMaterialState(WidgetState.pressed),
      onHover: updateMaterialState(WidgetState.hovered),
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      excludeFromSemantics: true,
      onFocusChange: updateMaterialState(WidgetState.focused),
      child: Row(
        spacing: DsfrSpacings.s2w,
        children: [
          DsfrFocusWidget(
            isFocused: isFocused,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: _Switch(value: widget.value),
          ),
          Flexible(child: Text(widget.label, style: const DsfrTextStyle.bodyMd())),
        ],
      ),
    ),
  );
}

class _Switch extends StatelessWidget {
  const _Switch({required this.value});

  final bool value;

  @override
  Widget build(final context) {
    const width = 40.0;
    const height = 24.0;
    const offset = width - height;
    const primary = DsfrColors.blueFranceSun113;
    const border = Border.fromBorderSide(BorderSide(color: primary));
    const borderRadius = BorderRadius.all(Radius.circular(height));

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(decoration: BoxDecoration(color: value ? primary : null, border: border, borderRadius: borderRadius)),
          Positioned(
            left: value ? offset : 0,
            top: 0,
            right: value ? 0 : offset,
            bottom: 0,
            child:
                value
                    ? const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white, border: border, shape: BoxShape.circle),
                      child: Icon(DsfrIcons.systemCheckLine, size: 16, color: primary),
                    )
                    : const DecoratedBox(decoration: BoxDecoration(border: border, borderRadius: borderRadius)),
          ),
        ],
      ),
    );
  }
}
