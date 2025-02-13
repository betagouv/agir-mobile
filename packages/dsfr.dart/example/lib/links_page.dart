import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  static final model = PageItem(
    title: 'Lien',
    pageBuilder: (final context) => const LinksPage(),
  );

  void _handleTap() {}

  @override
  Widget build(final context) {
    const label = 'Label lien';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s2w,
        children: [
          const DsfrLink.md(label: label),
          DsfrLink.md(label: label, onTap: _handleTap),
          DsfrLink.md(
            label: label,
            icon: DsfrIcons.systemArrowLeftLine,
            onTap: _handleTap,
          ),
          DsfrLink.md(
            label: label,
            icon: DsfrIcons.systemArrowLeftLine,
            iconPosition: DsfrLinkIconPosition.end,
            onTap: _handleTap,
          ),
        ],
      ),
    );
  }
}
