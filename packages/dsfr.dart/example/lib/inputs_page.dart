import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class InputsPage extends StatelessWidget {
  const InputsPage({super.key});

  static final model = PageItem(
    title: 'Champ de saisie',
    pageBuilder: (final context) => const InputsPage(),
  );

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DsfrInput(
              label: 'Label',
              onChanged: (final String value) {},
            ),
          ],
        ),
      );
}
