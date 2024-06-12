import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class AccordionsPage extends StatelessWidget {
  const AccordionsPage({super.key});

  static final model = PageItem(
    title: 'Accordéon',
    pageBuilder: (final context) => const AccordionsPage(),
  );

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          DsfrAccordionsGroup(
            values: [
              DsfrAccordion(
                headerBuilder: (isExpanded) =>
                    isExpanded ? Text('Header Expanded 1') : Text('Header 1'),
                body: Text('Body 1'),
              ),
              DsfrAccordion(
                headerBuilder: (isExpanded) => Text('Header 2'),
                body: Text('Body 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
