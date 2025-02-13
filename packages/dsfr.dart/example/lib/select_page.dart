import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  static final model = PageItem(title: 'Liste déroulante', pageBuilder: (final context) => const SelectPage());

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      DsfrSelect(
        label: 'Label',
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: 1, label: 'Un'),
          DropdownMenuEntry(value: 2, label: 'Deux'),
          DropdownMenuEntry(value: 3, label: 'Trois'),
        ],
        onSelected: (final value) {},
      ),
      DsfrSelect(label: 'Label', dropdownMenuEntries: const [], onSelected: (final value) {}),
    ],
  );
}
