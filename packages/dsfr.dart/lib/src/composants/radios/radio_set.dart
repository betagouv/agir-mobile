import 'package:dsfr/src/composants/radios/radio_set_headless.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButtonSet<T> extends StatelessWidget {
  const DsfrRadioButtonSet({
    super.key,
    required this.title,
    required this.values,
    required this.onCallback,
    this.initialValue,
  });

  final String title;
  final Map<T, String> values;
  final T? initialValue;
  final Callback<T?> onCallback;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      Text(title, style: const DsfrTextStyle.bodyMd()),
      DsfrRadioButtonSetHeadless(
        values: values.map(
          (final key, final value) => MapEntry(key, DsfrRadioButtonItem(value)),
        ),
        onCallback: onCallback,
        initialValue: initialValue,
      ),
    ],
  );
}
