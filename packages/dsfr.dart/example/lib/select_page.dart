import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  static final model = PageItem(
    title: 'Liste déroulante',
    pageBuilder: (final context) => const SelectPage(),
  );

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DsfrSelect(
              label: 'Label',
              dropdownMenuEntries: [
                DropdownMenuEntry(label: 'Un', value: 1),
                DropdownMenuEntry(label: 'Deux', value: 2),
                DropdownMenuEntry(label: 'Trois', value: 3),
              ],
              onSelected: (final value) {},
            ),
            DsfrSelect(
              label: 'Label',
              dropdownMenuEntries: [],
              onSelected: (final value) {},
            ),
          ],
        ),
      );
}
