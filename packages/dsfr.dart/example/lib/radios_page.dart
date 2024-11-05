import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class RadiosPage extends StatefulWidget {
  const RadiosPage({super.key});

  static final model = PageItem(
    title: 'Radios',
    pageBuilder: (final context) => const RadiosPage(),
  );

  @override
  State<RadiosPage> createState() => _RadiosPageState();
}

class _RadiosPageState extends State<RadiosPage> {
  int _value = 0;

  @override
  Widget build(final context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DsfrRadioButtonSet(
            title: 'Radios',
            values: const {1: 'Un', 2: 'Deux', 3: 'Trois'},
            onCallback: (final p0) {},
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          DsfrRadioButton<int>(
            title: 'Un',
            value: 0,
            groupValue: _value,
            onChanged: (final value) {
              if (value != null) {
                setState(() {
                  _value = value;
                });
              }
            },
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          DsfrRadioButton<int>(
            title: 'Deux',
            value: 1,
            groupValue: _value,
            onChanged: (final value) {
              if (value != null) {
                setState(() {
                  _value = value;
                });
              }
            },
          ),
          const SizedBox(height: DsfrSpacings.s1w),
          DsfrRadioButton<int>(
            title: 'Trois',
            value: 2,
            groupValue: _value,
            onChanged: (final value) {
              if (value != null) {
                setState(() {
                  _value = value;
                });
              }
            },
          ),
        ],
      );
}
