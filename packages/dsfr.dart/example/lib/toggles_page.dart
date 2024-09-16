import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class TogglesPage extends StatefulWidget {
  const TogglesPage({super.key});

  static final model = PageItem(
    title: 'Interrupteur',
    pageBuilder: (final context) => const TogglesPage(),
  );

  @override
  State<TogglesPage> createState() => _TogglesPageState();
}

class _TogglesPageState extends State<TogglesPage> {
  bool _toggle = false;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DsfrToggle(
              label: 'Vos favoris',
              value: _toggle,
              onChanged: (final value) {
                setState(() {
                  _toggle = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DsfrToggle(
              label: 'Vos favoris',
              value: !_toggle,
              onChanged: (final value) {
                setState(() {
                  _toggle = !value;
                });
              },
            ),
          ],
        ),
      );
}
