import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class DsfrInput extends StatefulWidget {
  const DsfrInput({
    required this.label,
    required this.onChanged,
    this.hint,
    this.controller,
    this.width,
    this.labelStyle = DsfrFonts.bodyMd,
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = DsfrFonts.bodyXs,
    this.hintColor = DsfrColors.grey425,
    this.inputStyle = DsfrFonts.bodyMd,
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
    super.key,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  final double? width;
  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;
  final TextStyle inputStyle;
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

  @override
  State<DsfrInput> createState() => _DsfrInputState();
}

class _DsfrInputState extends State<DsfrInput> {
  final _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        setState(() {
          isFocused = _focusNode.hasFocus;
        });
      },
    );
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
        SizedBox(
          height: isFocused ? DsfrSpacings.s1v : DsfrSpacings.s1w,
        ),
        DecoratedBox(
          decoration: isFocused
              ? BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(widget.radius),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: widget.focusColor,
                      width: widget.focusThickness,
                    ),
                  ),
                )
              : const BoxDecoration(),
          child: Padding(
            padding: isFocused
                ? widget.focusPadding
                    .add(EdgeInsets.only(bottom: widget.inputBorderWidth))
                : EdgeInsets.zero,
            child: SizedBox(
              width: widget.width,
              child: TextField(
                controller: widget.controller,
                style: widget.inputStyle,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: widget.fillColor,
                  enabledBorder: underlineInputBorder,
                  focusedBorder: underlineInputBorder,
                  border: underlineInputBorder,
                  constraints: widget.inputConstraints,
                ),
                keyboardType: widget.keyboardType,
                obscureText: widget.passwordMode,
                enableSuggestions: !widget.passwordMode,
                autocorrect: !widget.passwordMode,
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
