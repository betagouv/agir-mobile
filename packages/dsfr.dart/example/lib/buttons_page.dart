import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  static final model = PageItem(
    title: 'Bouton',
    pageBuilder: (final context) => const ButtonsPage(),
  );

  @override
  Widget build(final BuildContext context) {
    const label = 'Bouton';
    const gap = SizedBox(height: 16);
    void onTap() {}

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const DsfrButton.lg(label: label),
          gap,
          DsfrButton.lg(label: label, onTap: onTap),
        ],
      ),
    );
  }
}
