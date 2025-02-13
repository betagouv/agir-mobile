import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class InputsPage extends StatelessWidget {
  const InputsPage({super.key});

  static final model = PageItem(title: 'Champ de saisie', pageBuilder: (final context) => const InputsPage());

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: DsfrInput(label: 'Label', onChanged: (final value) {})),
          Expanded(child: DsfrInput(label: 'Label', onChanged: (final value) {})),
        ],
      ),
      const DsfrInput(label: 'Password', onChanged: print, isPasswordMode: true),
      const DsfrInputHeadless(onChanged: print),
    ],
  );
}
