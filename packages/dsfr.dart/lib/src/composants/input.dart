// ignore_for_file: prefer-correct-callback-field-name

import 'package:dsfr/src/composants/checkbox.dart';
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
    this.initialValue,
    this.validator,
    this.width,
    this.labelStyle = DsfrFonts.bodyMd,
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = DsfrFonts.bodyXs,
    this.hintColor = DsfrColors.grey425,
    this.inputStyle = DsfrFonts.bodyMd,
    this.textAlign = TextAlign.start,
    this.isPasswordMode = false,
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
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;

  final double? width;
  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;
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
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  final _focusNode = FocusNode();
  bool _passwordVisibility = false;

  void _handlePasswordVisibility(final bool value) =>
      setState(() => _passwordVisibility = value);

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

    Widget label = Text(
      widget.label,
      style: widget.labelStyle.copyWith(color: widget.labelColor),
    );

    if (widget.isPasswordMode) {
      label = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: label),
          if (widget.isPasswordMode)
            DsfrCheckbox.sm(
              label: 'Afficher',
              value: _passwordVisibility,
              onChanged: _handlePasswordVisibility,
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        if (widget.hint != null) ...[
          const SizedBox(height: DsfrSpacings.s1v),
          Text(
            widget.hint!,
            style: widget.hintStyle.copyWith(color: widget.hintColor),
          ),
        ],
        SizedBox(
          height: _focusNode.hasFocus ? DsfrSpacings.s1v : DsfrSpacings.s1w,
        ),
        DecoratedBox(
          decoration: _focusNode.hasFocus
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
            padding: _focusNode.hasFocus
                ? widget.focusPadding
                    .add(EdgeInsets.only(bottom: widget.inputBorderWidth))
                : EdgeInsets.zero,
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
                obscureText: widget.isPasswordMode && !_passwordVisibility,
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
        ),
      ],
    );
  }
}
