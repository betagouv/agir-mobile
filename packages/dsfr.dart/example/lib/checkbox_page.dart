import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  static final model = PageItem(
    title: 'Case à cocher',
    pageBuilder: (final context) => const CheckboxPage(),
  );

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _value = false;
  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DsfrCheckbox.sm(
              label: 'Label',
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value ?? false;
                });
              },
            ),
            DsfrCheckbox.sm(
              label: 'Label',
              value: false,
              onChanged: (bool? value) {},
            ),
            DsfrCheckbox.sm(
              label: 'Label',
              value: true,
              onChanged: (bool? value) {},
            ),
          ],
        ),
      );
}
