import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  static final model = PageItem(
    title: 'Lien',
    pageBuilder: (final context) => const LinksPage(),
  );

  @override
  Widget build(final BuildContext context) {
    const label = 'Label lien';
    const gap = SizedBox(height: 16);
    void onTap() {}

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const DsfrLink.md(label: label),
          gap,
          DsfrLink.md(label: label, onTap: onTap),
        ],
      ),
    );
  }
}
