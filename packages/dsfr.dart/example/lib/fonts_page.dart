import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class FontsPage extends StatelessWidget {
  const FontsPage({super.key});

  static final model = PageItem(
    title: 'Typographie',
    pageBuilder: (final context) => const FontsPage(),
  );

  @override
  Widget build(final BuildContext context) => const Text('Fonts');
}
