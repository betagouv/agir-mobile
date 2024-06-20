import 'package:dsfr/src/composants/radios/radio.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

typedef Callback<T> = void Function(T value);

class DsfrRadioButtonSetHeadless<T> extends StatefulWidget {
  const DsfrRadioButtonSetHeadless({
    required this.values,
    required this.onCallback,
    this.initialValue,
    super.key,
  });

  final Map<T, String> values;
  final T? initialValue;
  final Callback<T?> onCallback;

  @override
  State<DsfrRadioButtonSetHeadless<T>> createState() =>
      _DsfrRadioButtonSetHeadlessState<T>();
}

class _DsfrRadioButtonSetHeadlessState<T>
    extends State<DsfrRadioButtonSetHeadless<T>> {
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
  Widget build(final BuildContext context) => Wrap(
        spacing: DsfrSpacings.s1w,
        runSpacing: DsfrSpacings.s1w,
        children: widget.values.entries
            .map(
              (final e) => DsfrRadioButton<T?>(
                title: e.value,
                value: e.key,
                groupValue: _value,
                onChanged: _handleChange,
              ),
            )
            .toList(),
      );
}
