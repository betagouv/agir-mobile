import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrSelect<T> extends StatelessWidget {
  const DsfrSelect({
    required this.label,
    required this.dropdownMenuEntries,
    required this.onSelected,
    this.hint,
    this.labelStyle = DsfrFonts.bodyMd,
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = DsfrFonts.bodyXs,
    this.hintColor = DsfrColors.grey425,
    this.inputStyle = DsfrFonts.bodyMd,
    this.inputBorderColor = DsfrColors.grey200,
    this.inputBorderWidth = 2,
    this.inputConstraints = const BoxConstraints(maxHeight: 48),
    this.fillColor = DsfrColors.grey950,
    this.radius = 4,
    super.key,
  });

  final String label;
  final String? hint;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final ValueChanged<T?> onSelected;

  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;
  final TextStyle inputStyle;
  final Color inputBorderColor;
  final double inputBorderWidth;
  final BoxConstraints inputConstraints;
  final Color fillColor;
  final double radius;

  @override
  Widget build(final BuildContext context) {
    final underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: inputBorderColor,
        width: inputBorderWidth,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
    );

    return _Label(
      label: label,
      hint: hint,
      labelStyle: labelStyle,
      labelColor: labelColor,
      hintStyle: hintStyle,
      hintColor: hintColor,
      child: DropdownMenu(
        trailingIcon: const Icon(
          DsfrIcons.systemArrowDownSLine,
          size: DsfrSpacings.s2w,
        ),
        selectedTrailingIcon: const Icon(
          DsfrIcons.systemArrowUpSLine,
          size: DsfrSpacings.s2w,
        ),
        textStyle: inputStyle,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: fillColor,
          focusedBorder: underlineInputBorder,
          enabledBorder: underlineInputBorder,
          border: underlineInputBorder,
          constraints: inputConstraints,
        ),
        onSelected: onSelected,
        expandedInsets: EdgeInsets.zero,
        dropdownMenuEntries: dropdownMenuEntries,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
    required this.child,
    this.hint,
    this.labelStyle = DsfrFonts.bodyMd,
    this.labelColor = DsfrColors.grey50,
    this.hintStyle = DsfrFonts.bodyXs,
    this.hintColor = DsfrColors.grey425,
  });

  final String label;
  final String? hint;
  final Widget child;

  final TextStyle labelStyle;
  final Color labelColor;
  final TextStyle hintStyle;
  final Color hintColor;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style: labelStyle.copyWith(color: labelColor)),
          if (hint != null) ...[
            const SizedBox(height: DsfrSpacings.s1v),
            Text(hint!, style: hintStyle.copyWith(color: hintColor)),
          ],
          const SizedBox(height: DsfrSpacings.s1w),
          child,
        ],
      );
}