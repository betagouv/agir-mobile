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
  Widget build(final BuildContext context) => SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            DsfrRadioButtonSet(
              title: 'Revenu fiscal de référence de votre foyer',
              values: {
                1: 'Moins de 16 000 €',
                2: 'De 16 000 € à 35 000 €',
                3: 'Plus de 35 000 €',
              },
              onCallback: (p0) {},
            ),
            SizedBox(height: DsfrSpacings.s3w),
            DsfrRadioButton<int>(
              title: 'Moins de 16 000 €',
              value: 0,
              groupValue: _value,
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _value = value;
                  });
                }
              },
            ),
            SizedBox(height: DsfrSpacings.s1w),
            DsfrRadioButton<int>(
              title: 'De 16 000 € à 35 000 €',
              value: 1,
              groupValue: _value,
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _value = value;
                  });
                }
              },
            ),
            SizedBox(height: DsfrSpacings.s1w),
            DsfrRadioButton<int>(
              title: 'Plus de 35 000 €',
              value: 2,
              groupValue: _value,
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    _value = value;
                  });
                }
              },
            )
          ],
        ),
      );
}
