// ignore_for_file: prefer-correct-callback-field-name
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DsfrInputHeadless extends StatefulWidget {
  const DsfrInputHeadless({
    this.initialValue,
    this.controller,
    this.suffixText,
    required this.onChanged,
    this.validator,
    this.keyboardType,
    this.width,
    this.isPasswordMode = false,
    this.passwordVisibility = false,
    this.fillColor = DsfrColors.grey950,
    this.radius = DsfrSpacings.s1v,
    this.textAlign = TextAlign.start,
    this.inputStyle = DsfrFonts.bodyMd,
    this.inputBorderColor = DsfrColors.grey200,
    this.inputBorderWidth = DsfrSpacings.s0v5,
    this.inputConstraints = const BoxConstraints(maxHeight: DsfrSpacings.s6w),
    this.focusColor = DsfrColors.focus525,
    this.focusThickness = DsfrSpacings.s0v5,
    this.focusPadding = const EdgeInsets.all(DsfrSpacings.s1v),
    this.inputFormatters,
    super.key,
  });

  final bool passwordVisibility;
  final String? suffixText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final double? width;
  final TextStyle inputStyle;
  final TextAlign textAlign;
  final bool isPasswordMode;
  final TextInputType? keyboardType;
  final Color inputBorderColor;
  final double inputBorderWidth;
  final BoxConstraints inputConstraints;
  final Color fillColor;
  final double radius;
  final Color focusColor;
  final double focusThickness;
  final EdgeInsetsGeometry focusPadding;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DsfrInputHeadless> createState() => _DsfrInputHeadlessState();
}

class _DsfrInputHeadlessState extends State<DsfrInputHeadless> {
  bool _isFocused = false;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_listener);
  }

  void _listener() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_listener)
      ..dispose();
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

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(
            color: _isFocused ? widget.focusColor : Colors.transparent,
            width: widget.focusThickness,
          ),
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.radius),
        ),
      ),
      child: Padding(
        padding: widget.focusPadding
            .add(EdgeInsets.only(bottom: widget.inputBorderWidth)),
        child: SizedBox(
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            focusNode: _focusNode,
            decoration: InputDecoration(
              suffixText: widget.suffixText,
              suffixStyle: widget.inputStyle,
              filled: true,
              fillColor: widget.fillColor,
              focusedBorder: underlineInputBorder,
              enabledBorder: underlineInputBorder,
              border: underlineInputBorder,
              constraints: widget.inputConstraints,
            ),
            keyboardType: widget.keyboardType,
            style: widget.inputStyle,
            textAlign: widget.textAlign,
            obscureText: widget.isPasswordMode && !widget.passwordVisibility,
            autocorrect: !widget.isPasswordMode,
            enableSuggestions: !widget.isPasswordMode,
            onChanged: widget.onChanged,
            onTapOutside: (final event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
          ),
        ),
      ),
    );
  }
}
