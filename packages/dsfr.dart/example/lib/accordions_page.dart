import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class AccordionsPage extends StatelessWidget {
  const AccordionsPage({super.key});

  static final model = PageItem(title: 'Accordéon', pageBuilder: (final context) => const AccordionsPage());

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      DsfrAccordionsGroup(
        values: [
          DsfrAccordion(
            headerBuilder: (final isExpanded) => isExpanded ? const Text('Header Expanded 1') : const Text('Header 1'),
            body: const Text('Body 1'),
          ),
          DsfrAccordion(headerBuilder: (final isExpanded) => const Text('Header 2'), body: const Text('Body 2')),
        ],
      ),
    ],
  );
}
