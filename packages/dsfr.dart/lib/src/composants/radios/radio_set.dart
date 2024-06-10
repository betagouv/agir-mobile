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
    this.initialValue,
    super.key,
  });

  final String title;
  final Map<T, String> values;
  final T? initialValue;
  final Callback<T?> onCallback;

  @override
  State<DsfrRadioButtonSet<T>> createState() => _DsfrRadioButtonSetState<T>();
}

class _DsfrRadioButtonSetState<T> extends State<DsfrRadioButtonSet<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(final T? value) => setState(() {
        _value = value;
        widget.onCallback(_value);
      });

  @override
  Widget build(final BuildContext context) {
    final values = widget.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: DsfrFonts.bodyMd),
        const SizedBox(height: DsfrSpacings.s1w),
        ...values.entries
            .map(
              (final e) => DsfrRadioButton<T?>(
                title: e.value,
                value: e.key,
                groupValue: _value,
                onChanged: _handleChange,
              ),
            )
            .separator(const SizedBox(height: DsfrSpacings.s1w)),
      ],
    );
  }
}
