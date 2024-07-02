// ignore_for_file: prefer-correct-callback-field-name

import 'package:dsfr/src/composants/checkbox.dart';
import 'package:dsfr/src/composants/input_headless.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DsfrInput extends StatefulWidget {
  const DsfrInput({
    required this.label,
    this.hint,
    required this.onChanged,
    this.suffixText,
    this.controller,
    this.initialValue,
    this.validator,
    this.width,
    this.labelStyle = const DsfrTextStyle.bodyMd(),
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = const DsfrTextStyle.bodyXs(),
    this.hintColor = DsfrColors.grey425,
    this.textAlign = TextAlign.start,
    this.isPasswordMode = false,
    this.keyboardType,
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
  final TextAlign textAlign;
  final bool isPasswordMode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  bool _passwordVisibility = false;

  void _handlePasswordVisibility(final bool value) =>
      setState(() => _passwordVisibility = value);

  @override
  Widget build(final BuildContext context) {
    final labelText = widget.label;
    Widget label = Text(
      labelText,
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
        DsfrInputHeadless(
          initialValue: widget.initialValue,
          controller: widget.controller,
          suffixText: widget.suffixText,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          width: widget.width,
          isPasswordMode: widget.isPasswordMode,
          passwordVisibility: _passwordVisibility,
          textAlign: widget.textAlign,
          inputFormatters: widget.inputFormatters,
          key: ValueKey(labelText),
        ),
      ],
    );
  }
}
