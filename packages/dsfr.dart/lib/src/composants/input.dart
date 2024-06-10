import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DsfrInput extends StatefulWidget {
  const DsfrInput({
    required this.label,
    required this.onChanged,
    this.hint,
    this.suffixText,
    this.controller,
    this.width,
    this.labelStyle = DsfrFonts.bodyMd,
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = DsfrFonts.bodyXs,
    this.hintColor = DsfrColors.grey425,
    this.inputStyle = DsfrFonts.bodyMd,
    this.textAlign = TextAlign.start,
    this.passwordMode = false,
    this.keyboardType,
    this.inputBorderColor = DsfrColors.grey200,
    this.inputBorderWidth = 2,
    this.inputConstraints = const BoxConstraints(maxHeight: 48),
    this.fillColor = DsfrColors.grey950,
    this.radius = 4,
    this.focusColor = DsfrColors.focus525,
    this.focusThickness = 2,
    this.focusPadding = const EdgeInsets.all(4),
    this.inputFormatters,
    super.key,
  });

  final String label;
  final String? hint;
  final String? suffixText;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  final double? width;
  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;
  final TextStyle inputStyle;
  final TextAlign textAlign;
  final bool passwordMode;
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
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: widget.labelStyle.copyWith(color: widget.labelColor),
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: DsfrSpacings.s1v),
          Text(
            widget.hint!,
            style: widget.hintStyle.copyWith(color: widget.hintColor),
          ),
        ],
        SizedBox(height: _isFocused ? DsfrSpacings.s1v : DsfrSpacings.s1w),
        DecoratedBox(
          decoration: _isFocused
              ? BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: widget.focusColor,
                      width: widget.focusThickness,
                    ),
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(widget.radius),
                  ),
                )
              : const BoxDecoration(),
          child: Padding(
            padding: _isFocused
                ? widget.focusPadding
                    .add(EdgeInsets.only(bottom: widget.inputBorderWidth))
                : EdgeInsets.zero,
            child: SizedBox(
              width: widget.width,
              child: TextField(
                controller: widget.controller,
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
                obscureText: widget.passwordMode,
                autocorrect: !widget.passwordMode,
                enableSuggestions: !widget.passwordMode,
                onChanged: widget.onChanged,
                inputFormatters: widget.inputFormatters,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
