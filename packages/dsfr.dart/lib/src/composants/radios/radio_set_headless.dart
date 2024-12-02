import 'package:dsfr/src/composants/radios/radio.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:dsfr/src/helpers/iterable_extension.dart';
import 'package:flutter/material.dart';

typedef Callback<T> = void Function(T value);

enum DsfrRadioButtonSetMode { row, column }

class DsfrRadioButtonItem {
  const DsfrRadioButtonItem(this.value, {this.backgroundColor});

  final String value;
  final Color? backgroundColor;
}

class DsfrRadioButtonSetHeadless<T> extends StatefulWidget {
  const DsfrRadioButtonSetHeadless({
    super.key,
    required this.values,
    required this.onCallback,
    this.initialValue,
    this.mode = DsfrRadioButtonSetMode.row,
    this.isEnabled = true,
  });

  final Map<T, DsfrRadioButtonItem> values;
  final T? initialValue;
  final Callback<T?> onCallback;
  final DsfrRadioButtonSetMode mode;
  final bool isEnabled;

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
  Widget build(final context) {
    final children = widget.values.entries
        .map(
          (final e) => DsfrRadioButton<T>(
            title: e.value.value,
            value: e.key,
            groupValue: _value,
            onChanged: widget.isEnabled ? _handleChange : null,
            backgroundColor: e.value.backgroundColor,
          ),
        )
        .toList();

    return switch (widget.mode) {
      DsfrRadioButtonSetMode.row => Wrap(
          spacing: DsfrSpacings.s1w,
          runSpacing: DsfrSpacings.s1w,
          children: children,
        ),
      DsfrRadioButtonSetMode.column => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children
              .separator(const SizedBox(height: DsfrSpacings.s1w))
              .toList(),
        ),
    };
  }
}
