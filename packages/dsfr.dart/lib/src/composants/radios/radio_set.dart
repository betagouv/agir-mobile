import 'package:dsfr/dsfr.dart';
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
        ListView.separated(
          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (final context, final index) {
            final item = values.entries.elementAt(index);
            return DsfrRadioButton(
              title: item.value,
              value: item.key,
              groupValue: _value,
              onChanged: (final value) {
                setState(() {
                  _value = value;
                  widget.onCallback.call(_value);
                });
              },
            );
          },
          separatorBuilder: (final context, final index) =>
              const SizedBox(height: DsfrSpacings.s1w),
        ),
      ],
    );
  }
}
