import 'package:dsfr/src/composants/radios/radio.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:dsfr/src/helpers/iterable_extension.dart';
import 'package:flutter/material.dart';

typedef Callback<T> = void Function(T value);

class DsfrRadioButtonSet<T> extends StatefulWidget {
  const DsfrRadioButtonSet({
    required this.title,
    required this.values,
    required this.onCallback,
    super.key,
  });

  final String title;
  final Map<T, String> values;
  final Callback<T?> onCallback;

  @override
  State<DsfrRadioButtonSet<T>> createState() => _DsfrRadioButtonSetState<T>();
}

class _DsfrRadioButtonSetState<T> extends State<DsfrRadioButtonSet<T>> {
  T? _value;

  @override
  Widget build(final BuildContext context) {
    final values = widget.values;

    return Column(
      children: [
        Text(widget.title, style: DsfrFonts.bodyMd),
        const SizedBox(height: DsfrSpacings.s1w),
        ...values.entries
            .map(
              (final e) => DsfrRadioButton(
                title: e.value,
                value: e.key,
                groupValue: _value,
                onChanged: (final value) {
                  setState(() {
                    _value = value;
                    widget.onCallback(_value);
                  });
                },
              ),
            )
            .separator(const SizedBox(height: DsfrSpacings.s1w)),
      ],
    );
  }
}
