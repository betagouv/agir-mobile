import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  static final model = PageItem(
    title: 'Couleurs - Palette',
    pageBuilder: (final context) => const ColorsPage(),
  );

  @override
  Widget build(final context) => const Text('Colors');
}
