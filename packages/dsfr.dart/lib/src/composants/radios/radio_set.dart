import 'package:dsfr/src/composants/radios/radio_set_headless.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButtonSet<T> extends StatelessWidget {
  const DsfrRadioButtonSet({
    required this.title,
    required this.values,
    required this.onCallback,
    this.initialValue,
    super.key,
  });

  final String title;
  final Map<T, String> values;
  final T? initialValue;
  final Callback<T?> onCallback;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DsfrFonts.bodyMd),
          const SizedBox(height: DsfrSpacings.s1w),
          DsfrRadioButtonSetHeadless(
            values: values,
            onCallback: onCallback,
            initialValue: initialValue,
          ),
        ],
      );
}
