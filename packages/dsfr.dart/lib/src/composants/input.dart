import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrInput extends StatefulWidget {
  const DsfrInput({
    required this.label,
    required this.onChanged,
    this.labelStyle = DsfrFonts.bodyMd,
    this.inputStyle = DsfrFonts.bodyMd,
    this.passwordMode = false,
    this.keyboardType,
    this.inputBorderColor = DsfrColors.grey200,
    this.inputBorderWidth = 2,
    this.fillColor = DsfrColors.grey950,
    this.radius = 4,
    this.focusColor = DsfrColors.focus525,
    this.focusThickness = 2,
    this.focusPadding = const EdgeInsets.all(4),
    super.key,
  });

  final String label;
  final TextStyle labelStyle;
  final TextStyle inputStyle;
  final ValueChanged<String> onChanged;
  final bool passwordMode;
  final TextInputType? keyboardType;
  final Color inputBorderColor;
  final double inputBorderWidth;
  final Color fillColor;
  final double radius;
  final Color focusColor;
  final double focusThickness;
  final EdgeInsetsGeometry focusPadding;

  @override
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  final _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: widget.inputBorderColor,
        width: widget.inputBorderWidth,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(widget.radius)),
    );

    Widget child = TextField(
      style: widget.inputStyle,
      focusNode: _focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        enabledBorder: underlineInputBorder,
        focusedBorder: underlineInputBorder,
        border: underlineInputBorder,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.passwordMode,
      enableSuggestions: !widget.passwordMode,
      autocorrect: !widget.passwordMode,
      onChanged: widget.onChanged,
    );

    if (isFocused) {
      child = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(widget.radius)),
          border: Border.fromBorderSide(
            BorderSide(
              color: widget.focusColor,
              width: widget.focusThickness,
            ),
          ),
        ),
        child: Padding(
          padding: widget.focusPadding
              .add(EdgeInsets.only(bottom: widget.inputBorderWidth)),
          child: child,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: widget.labelStyle),
        SizedBox(
          height: isFocused ? DsfrSpacings.s1v : DsfrSpacings.s1w,
        ),
        child,
      ],
    );
  }
}
