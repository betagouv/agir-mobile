// ignore_for_file: avoid-collection-mutating-methods

import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class IconsPage extends StatelessWidget {
  const IconsPage({super.key});

  static final model = PageItem(
    title: 'Icône',
    pageBuilder: (final context) => const IconsPage(),
  );

  @override
  Widget build(final BuildContext context) {
    const allIcons = DsfrIcons.all;
    final allIconsKeys = allIcons.keys.toList()..sort();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 11,
      ),
      itemBuilder: (final context, final index) {
        final allIconsKey = allIconsKeys.elementAtOrNull(index);

        return allIconsKey == null
            ? const SizedBox()
            : Column(
                children: [
                  Icon(
                    allIcons[allIconsKey],
                    size: 32,
                    color: DsfrColors.blueFranceSun113,
                  ),
                  Text(allIconsKey),
                ],
              );
      },
      itemCount: allIcons.length,
    );
  }
}
